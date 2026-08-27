#include "ksoserver.h"

#include <arpa/inet.h>
#include <net/if.h>
#include <netinet/in.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#include "inifile.h"

// The two events heaven reports through the handler registered with
// RegisterEventHandler. Named here because 256 and 257 are otherwise bare
// numbers in EventNotify.
static const int kEventClientCreate = 256;
static const int kEventClientClose  = 257;

// Ip2a @ 0x0804B4E0. inet_ntoa in everything but name; kept separate so the
// startup lines read the same as the original's.
static const char* Ip2a(unsigned long uAddr)
{
    struct in_addr a;
    a.s_addr = (in_addr_t)uAddr;
    return inet_ntoa(a);
}

// GetIpAddress @ 0x0804B2C0. SIOCGIFADDR on a throwaway UDP socket.
static bool GetIpAddress(const char* pszIfName, DWORD* pAddr)
{
    const int fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (fd < 0)
        return false;

    struct ifreq ifr;
    memset(&ifr, 0, sizeof(ifr));
    strncpy(ifr.ifr_name, pszIfName, IFNAMSIZ - 1);
    ifr.ifr_name[IFNAMSIZ - 1] = 0;
    ifr.ifr_addr.sa_family = AF_INET;

    if (ioctl(fd, SIOCGIFADDR, &ifr) != 0)
    {
        close(fd);
        return false;
    }
    close(fd);

    *pAddr = (DWORD)((struct sockaddr_in*)&ifr.ifr_addr)->sin_addr.s_addr;
    return true;
}

KSOServer::KSOServer()
    : m_dwElapseTime(0), m_dwOriginTime(0), m_dwOriginTick(0), m_dwElapseTick(0),
      m_dwGameTick(0), m_dwGameLoop(0), m_nGameFPS(0),
      m_nInternetIp(0), m_nIntranetIp(0),
      m_nMaxPlayer(0), m_nServerPort(0), m_bIsRunning(0),
      m_pServer(0), m_pServerCore(0)
{
    memset(m_aConnections, 0, sizeof(m_aConnections));
}

KSOServer::~KSOServer()
{
}

// ---------------------------------------------------------------------------
// Initialize @ 0x0804C0A0.
//
// Order matters and is preserved: libraries first, then config, then the
// listening socket, then the core. Loading heaven before reading servercfg.ini
// means a missing library is reported before a missing config, which is what
// the deployed logs look like.
// ---------------------------------------------------------------------------
BOOL KSOServer::Initialize(int nPort, BOOL bOpenGm)
{
    // Phase 2: g_SetRootPath(0) and g_InitEngine("package.ini", 0) open the
    // package VFS here, which is what makes the "\\settings\\..." paths in the
    // core resolvable. servercfg.ini is read from the filesystem either way.

    if (!m_cServerLib.Load())
        return 0;
    if (!m_cClientLib.Load())
        return 0;

    m_bIsRunning = 1;

    KIniFile iniFile;
    if (!iniFile.Load("servercfg.ini"))
    {
        puts("Failed to load servercfg.ini");
        return 0;
    }

    iniFile.GetInteger("GameServer", "Port", 6666, &m_nServerPort);

    // FixIp pins the two addresses when the interface scan below would get them
    // wrong -- which it does on any host that is not on eth0/eth1. Only a
    // non-empty value overrides.
    char szFixIp[260];
    szFixIp[0] = 0;
    iniFile.GetString("FixIp", "InternetIp", "", szFixIp, 0x104u);
    if (szFixIp[0])
        m_nInternetIp = inet_addr(szFixIp);
    szFixIp[0] = 0;
    iniFile.GetString("FixIp", "IntranetIp", "", szFixIp, 0x104u);
    if (szFixIp[0])
        m_nIntranetIp = inet_addr(szFixIp);

    // The command line wins over the file, so a second instance can be brought
    // up on another port without editing config.
    if (nPort > 0)
        m_nServerPort = nPort;

    // The five outbound links, read in the shipped order. 5 MB of buffer each
    // is the default the shipped code seeds sConnection with before every call.
    //
    // GODDESS is the DATABASE and BISHOP is the GATEWAY -- the enum names read
    // backwards and they are the easiest thing in this file to get wrong. Three
    // independent places in the binary agree:
    //   * KSOServer::SendDataToServer @0x804b120 routes GODDESS to m_connDatabase
    //     and BISHOP to m_connGateway;
    //   * KGoddessProcess::Process @0x81ec7e0 calls DatabaseLargePackProcess and
    //     prints "Protocol:(%d) -- database error";
    //   * KBishopProcess::ProcessMessage @0x81ed9e0 calls GatewayLargePackProcess
    //     / GatewaySmallPackProcess.
    // Keeping the array indexed by KE_SERVERTYPE means SendDataToServer is a
    // plain m_aConnections[nType] with no fixup, so the naming quirk is spent
    // once, here.
    static const struct { KE_SERVERTYPE eType; const char* pszSection; } kLinks[] = {
        { emSERVER_GODDESS, "Database" },
        { emSERVER_BISHOP,  "Gateway"  },
        { emSERVER_HOST,    "Transfer" },
        { emSERVER_CHAT,    "Chat"     },
        { emSERVER_TONG,    "Tong"     },
    };
    for (size_t i = 0; i < sizeof(kLinks) / sizeof(kLinks[0]); ++i)
    {
        KCONNECTION conn;
        conn.szIp[0]  = 0;
        conn.nPort    = 0;
        conn.nBufSize = 5242880;
        LoadConnection(&iniFile, kLinks[i].pszSection, &conn);
        m_aConnections[kLinks[i].eType] = conn;
    }

    int nMaxPlayerCount = 0;
    int nPrecision = 0;
    iniFile.GetInteger("Overload", "MaxPlayer", 1000, &nMaxPlayerCount);
    iniFile.GetInteger("Overload", "Precision", 200, &nPrecision);
    m_nMaxPlayer = nMaxPlayerCount + nPrecision;
    if (m_nMaxPlayer <= 0)
    {
        puts("Maximal player number <= 0!");
        return 0;
    }

    DWORD nInternetIp = 0;
    DWORD nIntranetIp = 0;
    if (!GetLocalIpAddress(&nIntranetIp, &nInternetIp))
    {
        puts("Can't get server ip");
        return 0;
    }
    if (!nInternetIp)
        nInternetIp = nIntranetIp;
    if (!m_nInternetIp)
        m_nInternetIp = nInternetIp;
    if (!m_nIntranetIp)
        m_nIntranetIp = nIntranetIp;

    printf("Intranet ip: %s\n", Ip2a(m_nIntranetIp));
    printf("Internet ip: %s\n", Ip2a(m_nInternetIp));

    if (!CreateServer())
        return 0;

    if (!CreateCore(&m_pServerCore, m_nMaxPlayer, bOpenGm))
    {
        puts("Failed to Create ServerCore.");
        return 0;
    }

    if (!m_pServerCore->Initialize(this, m_pServer))
    {
        puts("Failed to initialize ServerCore.");
        m_pServerCore->Release();
        m_pServerCore = 0;
        return 0;
    }

    // The clock's zero point. Both counters are offsets from here, so they are
    // set together and never again.
    struct timeval tv;
    gettimeofday(&tv, 0);
    m_dwOriginTime = 1000 * tv.tv_sec + tv.tv_usec / 1000;
    m_dwOriginTick = 144 * tv.tv_sec + 144 * tv.tv_usec / 1000000;
    m_dwGameTick = 0;
    m_dwGameLoop = 0;

    if (!CreateClientConnections())
        return 0;

    FILE* fp = fopen("gameserver.log", "a+b");
    if (fp)
    {
        time_t ltime;
        time(&ltime);
        struct tm* t = localtime(&ltime);
        char buffer[255];
        sprintf(buffer, "[%04d-%02d-%02d %02d:%02d:%02d]Gameserver startup\r\n",
                t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
                t->tm_hour, t->tm_min, t->tm_sec);
        fwrite(buffer, 1, strlen(buffer), fp);
        fclose(fp);
    }
    return 1;
}

// ---------------------------------------------------------------------------
// UnInitialize @ 0x0804BCC0. Core down first, then the listening socket, then
// the libraries -- the reverse of Initialize, and it has to be: heaven's
// worker thread is still calling into the core until CloseService returns.
// ---------------------------------------------------------------------------
void KSOServer::UnInitialize()
{
    if (m_pServerCore)
    {
        m_pServerCore->UnInitialize();
        m_pServerCore->Release();
        m_pServerCore = 0;
    }

    if (m_pServer)
    {
        m_pServer->CloseService();
        m_pServer->UnInitialize();
        m_pServer->Release();
        m_pServer = 0;
    }

    CloseClientConnections();

    FILE* fp = fopen("gameserver.log", "a+b");
    if (fp)
    {
        time_t ltime;
        time(&ltime);
        struct tm* t = localtime(&ltime);
        char buffer[255];
        sprintf(buffer, "[%04d-%02d-%02d %02d:%02d:%02d]Gameserver close\r\n",
                t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
                t->tm_hour, t->tm_min, t->tm_sec);
        fwrite(buffer, 1, strlen(buffer), fp);
        fclose(fp);
    }

    m_cServerLib.Unload();
    m_cClientLib.Unload();
}

// ---------------------------------------------------------------------------
// CreateServer @ 0x0804B1B0.
//
// 204800 is the per-client buffer heaven allocates, and m_nMaxPlayer is how
// many of them -- so the listening side reserves MaxPlayer * 200 KB up front.
//
// The coder is registered BEFORE Initialize, because heaven's worker thread
// starts there and the first packet can arrive immediately after.
// ---------------------------------------------------------------------------
BOOL KSOServer::CreateServer()
{
    IServer* pServer = 0;
    if (!m_cServerLib.Create()(m_nMaxPlayer, 204800u, &pServer) || !pServer)
        return 0;

    pServer->RegisterCoder(&m_cCoder);
    m_pServer = pServer;
    pServer->RegisterEventHandler(this, KSOServer::ServerEventNotify);

    if (pServer->Initialize())
    {
        // Binds the INTERNET address, not the intranet one -- so on a host
        // where the two differ, this is the address clients must reach and a
        // wrong FixIp here means the listen fails outright.
        if (pServer->OpenService(m_nInternetIp, (unsigned short)m_nServerPort))
            return 1;

        printf("Failed to open service on port[%d]!\n", m_nServerPort);
        pServer->UnInitialize();
    }

    pServer->Release();
    m_pServer = 0;
    return 0;
}

BOOL KSOServer::CreateCore(IServerCore** ppCore, int nMaxPlayerCount, BOOL bOpenGm)
{
    return CreateServerCore(ppCore, nMaxPlayerCount, bOpenGm);
}

// ---------------------------------------------------------------------------
// LoadConnection @ 0x0804B530. The Ip default is the shipped one, oddities
// included -- 192.168.26.1 was somebody's LAN.
// ---------------------------------------------------------------------------
void KSOServer::LoadConnection(KIniFile* pIni, LPCSTR pszSection,
                               KCONNECTION* pConnection)
{
    pIni->GetString(pszSection, "Ip", "192.168.26.1", pConnection->szIp, 0x10u);
    pIni->GetInteger(pszSection, "Port", pConnection->nPort, &pConnection->nPort);
    pIni->GetInteger(pszSection, "BufferSize", pConnection->nBufSize, &pConnection->nBufSize);
    if (pConnection->nBufSize <= 0)
        pConnection->nBufSize = 10485760;
}

// ---------------------------------------------------------------------------
// GetLocalIpAddress @ 0x0804B360.
//
// eth0 is taken as the internet side and eth1 as the intranet side -- unless
// eth0's address starts 192.168, in which case the two are swapped, on the
// reasoning that a private address cannot be the public one. Always succeeds:
// with no interfaces at all both come back 0 and FixIp has to supply them.
// ---------------------------------------------------------------------------
BOOL KSOServer::GetLocalIpAddress(DWORD* pIntranetAddr, DWORD* pInternetAddr)
{
    DWORD dwEth0 = 0;
    DWORD dwEth1 = 0;
    GetIpAddress("eth0", &dwEth0);
    GetIpAddress("eth1", &dwEth1);

    if (!dwEth1)
        dwEth1 = dwEth0;
    if (!dwEth0)
        dwEth0 = dwEth1;

    // 0xA8C0 is 192.168 read as a little-endian WORD.
    if ((dwEth0 & 0xFFFF) == 0xA8C0)
    {
        *pIntranetAddr = dwEth0;
        *pInternetAddr = dwEth1;
    }
    else
    {
        *pIntranetAddr = dwEth1;
        *pInternetAddr = dwEth0;
    }
    return 1;
}

// ---------------------------------------------------------------------------
// The five outbound links. Phase 2.
//
// Each is a CClientConnection subclass with its own protocol against gateway,
// database, transfer, chat and tong; opening one means an IClient from
// librainbow, an event handler, a reconnect policy and the matching inbound
// processor in the core. None of that is on the path from accept to login,
// which is what Phase 1 covers, so the config above is read and reported and
// nothing is dialled.
//
// The shipped CreateClientConnections returns 0 if any link fails to connect,
// and Initialize then fails -- so the real server does not start without its
// gateway. That difference is deliberate and temporary; see docs/PHASE1.md.
// ---------------------------------------------------------------------------
BOOL KSOServer::CreateClientConnections()
{
    // Indexed by KE_SERVERTYPE, so it follows the load table above: slot 0 is
    // GODDESS, which is the database.
    static const char* const kNames[emSERVER_COUNT] =
        { "Database", "Gateway", "Transfer", "Tong", "Chat" };

    for (int i = 0; i < emSERVER_COUNT; ++i)
        printf("[%s]IP:%s, Port:%u\n", kNames[i], m_aConnections[i].szIp,
               (unsigned)m_aConnections[i].nPort);

    puts("[phase1] outbound server links are not opened by this build.");
    return 1;
}

void KSOServer::CloseClientConnections()
{
}

// ---------------------------------------------------------------------------
// Run / Loop / MessageLoop / Breathe @ 0x0804BC90 / 0x0804B7C0 / 0x0804BB60 /
// 0x0804BA20.
//
// One thread, no blocking: heaven does the socket work on its own thread and
// leaves decoded packets in per-client queues, so this loop only ever drains
// queues and ticks the game. The 1 ms sleep is what keeps it from spinning
// between ticks.
// ---------------------------------------------------------------------------
void KSOServer::Run()
{
    while (Loop())
        ;
}

BOOL KSOServer::Loop()
{
    struct timeval tv;
    gettimeofday(&tv, 0);

    m_dwElapseTime = 1000 * tv.tv_sec + tv.tv_usec / 1000 - m_dwOriginTime;
    m_dwElapseTick = 144 * tv.tv_sec + 144 * tv.tv_usec / 1000000 - m_dwOriginTick;

    MessageLoop();

    if (m_dwElapseTick >= m_dwGameTick)
        return Breathe();

    usleep(1000);
    return 1;
}

void KSOServer::MessageLoop()
{
    m_cLock.Lock();
    ProcessClientMessages();
    ProcessPlayerMessages();
    m_cLock.UnLock();
}

BOOL KSOServer::Breathe()
{
    m_cLock.Lock();

    BOOL bContinue;
    if (m_bIsRunning)
    {
        ++m_dwGameLoop;
        m_dwGameTick = 8 * m_dwGameLoop;   // 144/8 = 18 game loops per second
        if (m_dwElapseTick)
            m_nGameFPS = 144 * m_dwGameLoop / m_dwElapseTick;

        m_pServerCore->Breathe(m_dwGameLoop, m_dwElapseTime, m_nGameFPS);

        // Reproduced exactly, including what looks like an inverted test: the
        // warning fires on the 17 loops out of 18 that are NOT a multiple of
        // 18, so a struggling server prints this almost every tick. Changing
        // it would change the log the deployed stack is read against.
        if (m_nGameFPS <= 17 && (m_dwGameLoop % 18) != 0)
            printf("----------[Warning...] GameServer' FPS=%d----------\r\n", m_nGameFPS);

        bContinue = 1;
    }
    else
    {
        puts("GameServer exit...");
        m_pServerCore->Exit();
        usleep(5000000);
        bContinue = 0;
    }

    m_cLock.UnLock();
    return bContinue;
}

// ProcessClientMessages @ 0x0804B400 -- "client" here means the five links this
// process is a client OF, not the game clients. Those are the next function.
void KSOServer::ProcessClientMessages()
{
    m_pServerCore->MessageLoop();
    // Phase 2: drain the five outbound links into
    // IServerCore::ProcessServerMessage.
}

// ProcessPlayerMessages @ 0x0804AF80. Sweeps every client slot every loop and
// drains each one completely -- the inner loop stops only when heaven has no
// more whole packets for that slot.
void KSOServer::ProcessPlayerMessages()
{
    for (int i = 0; i < m_nMaxPlayer; ++i)
    {
        for (;;)
        {
            unsigned int nLen = 0;
            void* pData = m_pServer->GetPackFromClient((unsigned int)i, nLen);
            if (!pData || !nLen)
                break;
            m_pServerCore->ProcessClientMessage((unsigned int)i, pData, nLen);
        }
    }
}

// ---------------------------------------------------------------------------
// ServerEventNotify @ 0x0804B5F0 / EventNotify @ 0x0804AEB0.
//
// Called by heaven from ITS thread, which is the only reason the lock exists:
// OnClientCreate/OnClientClose write the same GameStatus array the main loop
// reads.
// ---------------------------------------------------------------------------
void KSOServer::ServerEventNotify(void* pContext, unsigned int nId, int nEvent)
{
    KSOServer* pThis = (KSOServer*)pContext;
    pThis->m_cLock.Lock();
    pThis->EventNotify(nId, nEvent);
    pThis->m_cLock.UnLock();
}

void KSOServer::EventNotify(unsigned int nId, int nEvent)
{
    if (!m_bIsRunning)
        return;

    if (nEvent == kEventClientCreate)
        m_pServerCore->OnClientCreate(nId);
    else if (nEvent == kEventClientClose)
        m_pServerCore->OnClientClose(nId);
}

// ---------------------------------------------------------------------------
// IGameServer.
// ---------------------------------------------------------------------------
void KSOServer::Exit()
{
    m_bIsRunning = 0;
}

BOOL KSOServer::SendDataToClient(unsigned long nId, const void* pData, unsigned int nLen)
{
    return m_pServer->PackDataToClient((unsigned int)nId, pData, nLen);
}

BOOL KSOServer::SendDataToServer(KE_SERVERTYPE nType, const void* pData, unsigned int nLen)
{
    (void)nType; (void)pData; (void)nLen;
    return 0;   // Phase 2: no outbound links
}

void KSOServer::ShutdownClient(unsigned long nId)
{
    if (nId < (unsigned long)m_nMaxPlayer)
        m_pServer->ShutdownClient((unsigned int)nId);
}

LPCSTR KSOServer::GetClientInfo(unsigned long nId)
{
    if (nId < (unsigned long)m_nMaxPlayer)
        return m_pServer->GetClientInfo((unsigned int)nId);
    return "";
}

const void* KSOServer::RecvGoddessMessage(unsigned int& nLen)
{
    nLen = 0;
    return 0;   // Phase 2: reads from the database link
}

unsigned long KSOServer::GetInternetIp() const { return m_nInternetIp; }
unsigned long KSOServer::GetIntranetIp() const { return m_nIntranetIp; }
int           KSOServer::GetPort() const       { return m_nServerPort; }

unsigned long KSOServer::GetBishopClientIp() const
{
    return 0;   // Phase 2: the address the database link bound locally
}
