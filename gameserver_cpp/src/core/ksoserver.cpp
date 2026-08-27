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

// ---------------------------------------------------------------------------
// KSOServer @ 0x0804B720.
//
// m_bIsRunning starts at 1, not 0: Exit() is the only thing that ever clears
// it, and it can be called from librainbow's thread before Run() is reached.
// ---------------------------------------------------------------------------
KSOServer::KSOServer()
    : m_dwElapseTime(0), m_dwOriginTime(0), m_dwOriginTick(0), m_dwElapseTick(0),
      m_dwGameTick(0), m_dwGameLoop(0), m_nGameFPS(0),
      m_nInternetIp(0), m_nIntranetIp(0),
      m_nMaxPlayer(0), m_nServerPort(6666), m_bIsRunning(1),
      m_pServer(0), m_pServerCore(0)
{
    // Iteration order, not enum order -- see the note in the header. The
    // gateway is deliberately index 4.
    m_pClientConnections[0] = &m_connDatabase;
    m_pClientConnections[1] = &m_connChat;
    m_pClientConnections[2] = &m_connTong;
    m_pClientConnections[3] = &m_connTran;
    m_pClientConnections[4] = &m_connGateway;

    for (int i = 0; i < emSERVER_COUNT; ++i)
        m_pClientConnections[i]->m_nIndex = i;

    // And here is the crossover, written once: GODDESS is the database link and
    // BISHOP is the gateway link. It is what SendDataToServer switches on and
    // what the core receives as the tag in ProcessServerMessage.
    m_connDatabase.m_nType = emSERVER_GODDESS;
    m_connGateway.m_nType  = emSERVER_BISHOP;
    m_connTran.m_nType     = emSERVER_HOST;
    m_connTong.m_nType     = emSERVER_TONG;
    m_connChat.m_nType     = emSERVER_CHAT;
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

    // The five outbound links, in the shipped order and with the shipped
    // quirk. One KCONNECTION is filled in and copied out five times, and
    // LoadConnection uses the CURRENT contents as GetInteger's defaults -- so
    // nPort and nBufSize carry from one section to the next.
    //
    // 5 MB is re-seeded exactly twice, before Gateway and before Database. It
    // is not seeded again, so Transfer, Chat and Tong inherit whatever
    // [Database] BufferSize resolved to. Reproduced rather than tidied: a
    // config that omits BufferSize under [Chat] gets the database's value on
    // the shipped server, and a "fix" here would allocate a different amount
    // of memory per link than the deployment has been tuned around.
    //
    // The section names are the crossover again, and this is the second and
    // last place it appears: [Database] feeds m_connDatabase, which the ctor
    // above tagged emSERVER_GODDESS, and [Gateway] feeds m_connGateway, tagged
    // emSERVER_BISHOP.
    KCONNECTION sConnection;
    sConnection.szIp[0]  = 0;
    sConnection.nPort    = 0;
    sConnection.nBufSize = 5242880;

    LoadConnection(&iniFile, "Gateway", &sConnection);
    m_connGateway.m_sConnection = sConnection;
    m_connGateway.m_pServer = this;

    sConnection.nBufSize = 5242880;
    LoadConnection(&iniFile, "Database", &sConnection);
    m_connDatabase.m_sConnection = sConnection;
    m_connDatabase.m_pServer = this;

    LoadConnection(&iniFile, "Transfer", &sConnection);
    m_connTran.m_sConnection = sConnection;
    m_connTran.m_pServer = this;

    LoadConnection(&iniFile, "Chat", &sConnection);
    m_connChat.m_sConnection = sConnection;
    m_connChat.m_pServer = this;

    LoadConnection(&iniFile, "Tong", &sConnection);
    m_connTong.m_sConnection = sConnection;
    m_connTong.m_pServer = this;

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
// CreateClientConnections @ 0x0804B490.
//
// All five or none: the first link that fails to dial stops the loop and
// Initialize fails with it. That is not defensiveness, it is the deployment
// contract -- a game server that came up without its database would accept
// logins it cannot persist.
//
// ConnectionResult is called on the failing link too, before the return, so a
// subclass sees the failure. Only the ping connection acts on it.
// ---------------------------------------------------------------------------
BOOL KSOServer::CreateClientConnections()
{
    for (int i = 0; i < emSERVER_COUNT; ++i)
    {
        CClientConnection* pConn = m_pClientConnections[i];
        const BOOL bResult = pConn->Open();
        pConn->ConnectionResult(bResult);
        if (!bResult)
            return 0;
    }
    return 1;
}

// @ 0x0804B450. Only links that reported success are closed -- a half-opened
// one has no IClient to shut down.
void KSOServer::CloseClientConnections()
{
    for (int i = 0; i < emSERVER_COUNT; ++i)
    {
        if (m_pClientConnections[i]->m_bResult)
            m_pClientConnections[i]->Close();
    }
}

// @ 0x0804B5E0 / 0x0804B5D0.
void KSOServer::Lock()   { m_cLock.Lock(); }
void KSOServer::UnLock() { m_cLock.UnLock(); }

// ---------------------------------------------------------------------------
// CreateClient @ 0x0804AF10.
//
// The 1 KB floor is librainbow's, enforced here rather than there. The coder
// handed over is m_cClientLib itself: KRainbowLib IS the ICoder for every
// outbound link, so all five share one, and it is the same cipher the inbound
// port uses through KCoder2.
// ---------------------------------------------------------------------------
BOOL KSOServer::CreateClient(int nBufLen, IClient** ppClient)
{
    if ((unsigned int)nBufLen <= 0x3FF)
        return 0;

    IClientManager* pManager = m_cClientLib.Manager();
    if (!pManager)
        return 0;

    IClient* pClient = 0;
    if (!pManager->CreateClient((unsigned int)nBufLen, &pClient, &m_cClientLib) || !pClient)
        return 0;

    *ppClient = pClient;
    return 1;
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
//
// The core's own MessageLoop runs first, before any link is drained: it flushes
// whatever last tick's traffic queued up, so the packets read below arrive at a
// core that has already caught up.
void KSOServer::ProcessClientMessages()
{
    m_pServerCore->MessageLoop();

    for (int i = 0; i < emSERVER_COUNT; ++i)
        m_pClientConnections[i]->ProcessMessages(m_pServerCore);
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

// @ 0x0804B120. A switch rather than m_pClientConnections[nType], because that
// array is in iteration order and this argument is a KE_SERVERTYPE. The two
// orders differ; see the header.
BOOL KSOServer::SendDataToServer(KE_SERVERTYPE nType, const void* pData, unsigned int nLen)
{
    switch (nType)
    {
    case emSERVER_GODDESS: return m_connDatabase.SendData(pData, nLen);
    case emSERVER_BISHOP:  return m_connGateway.SendData(pData, nLen);
    case emSERVER_HOST:    return m_connTran.SendData(pData, nLen);
    case emSERVER_TONG:    return m_connTong.SendData(pData, nLen);
    case emSERVER_CHAT:    return m_connChat.SendData(pData, nLen);
    default:               return 0;
    }
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

// @ 0x0804B100. The one link the core reads directly instead of through
// ProcessServerMessage: database replies are pulled synchronously at the point
// the core needs them.
const void* KSOServer::RecvGoddessMessage(unsigned int& nLen)
{
    return m_connDatabase.RecvData(nLen);
}

unsigned long KSOServer::GetInternetIp() const { return m_nInternetIp; }
unsigned long KSOServer::GetIntranetIp() const { return m_nIntranetIp; }
int           KSOServer::GetPort() const       { return m_nServerPort; }

// @ 0x0804B0D0. Text, and it is the configured gateway address -- what this
// server was told to dial, not what the socket ended up bound to.
LPCSTR KSOServer::GetBishopClientIp() const
{
    return m_connGateway.m_sConnection.szIp;
}
