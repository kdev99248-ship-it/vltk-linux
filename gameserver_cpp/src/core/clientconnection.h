// The five outbound server links.
//
// The game server is a client of five other processes -- gateway, database,
// transfer (relay), chat and tong -- and all five links are the SAME class.
// What differs is three virtuals and the name in the log:
//
//     CDatabaseConnection  "Goddess"   nothing overridden
//     CGatewayConnection   "Bishop"    nothing overridden
//     CTranConnection      "Tran"      IsPrime -> 1
//     CChatConnection      "Chat"      IsPrime -> 0
//     CTongConnection      "Tong"      via CClientPingConnection, IsPrime -> 1
//
// IsPrime is what decides whether losing the link kills the process. Only chat
// returns 0, so a chat server going down is survivable and any of the other
// four taking the link with it calls IGameServer::Exit().
//
// Recovered from _ZTV17CClientConnection @ 0x08249700 and the five subclass
// vtables at 0x08249460 (Chat), 0x082494C0 (Tran), 0x08249520 (Tong),
// 0x08249580 (Gateway), 0x082495E0 (Database), 0x08249760 (ClientPing); bodies
// at 0x0804CAB0 .. 0x0804D5B0. The DWARF gives CClientConnection as 676 bytes
// and CClientPingConnection as 692.
//
// Slot order below IS the shipped slot order, destructor first. Nothing outside
// this binary dispatches through these vtables -- unlike heaven_abi.h, where the
// order is a hard ABI -- but keeping it means a slot index read out of IDA can
// be counted off against the declarations without a translation step.
#ifndef JX_CORE_CLIENTCONNECTION_H
#define JX_CORE_CLIENTCONNECTION_H

#include "heaven_abi.h"
#include "logfile.h"
#include "windows.h"

class KSOServer;
struct IServerCore;

// One link, as configured. 16 bytes of IP text is what the shipped struct
// allows and what LoadConnection passes to GetString.
struct KCONNECTION
{
    char szIp[16];
    int  nPort;
    int  nBufSize;
};

class CClientConnection
{
public:
    explicit CClientConnection(LPCSTR pszConnection);
    virtual ~CClientConnection();                                       // [0][1]

    // Creates the IClient, dials, and opens Logs/conn_<name>_<date>.log.
    // Idempotent in the one way that matters: a second Open on a live object
    // reuses the existing IClient and only re-dials.
    BOOL Open();
    void Close();

    BOOL        SendData(const void* pData, unsigned int nLen);
    const void* RecvData(unsigned int& nLen);

    // Drains this link into IServerCore::ProcessServerMessage. Called once per
    // main-loop iteration, from KSOServer::ProcessClientMessages.
    void ProcessMessages(IServerCore* pCore);

    // Records whether Open succeeded. CClientPingConnection overrides it to
    // start its ping clock, which is the only reason it is virtual.
    virtual void ConnectionResult(BOOL bResult);                        // [2]

    // "Is this link essential?" Losing a prime link exits the process.
    virtual BOOL IsPrime();                                             // [3]

    // The per-link inbound filter. Returning 0 swallows the packet before the
    // core sees it -- which is how the ping reply never reaches the game.
    virtual BOOL TranslateMessage(void* pMsg, int size);                // [4]

    // Note the spelling: ISafety here, IsSafety on CClientPingConnection below.
    // Two different slots with two nearly identical names, both shipped.
    virtual BOOL ISafety();                                             // [5]

    // Runs every tick before the drain, whether or not there is traffic. Empty
    // in the base; CClientPingConnection uses it to send RELAY_PING.
    virtual void ApplyCheckSafety();                                    // [6]

    virtual void WriteLog(LPCSTR pszLog);                               // [7]
    virtual void ProcessMessage(void* pMsg, int size);                  // [8]

protected:
    // librainbow calls this from its own thread, which is why it takes the
    // server lock around everything it does.
    static void EventHandler(void* pParam, int nEvent);
    void OnConnectionCreate();
    void OnConnectionClose();

    friend class KSOServer;

    int         m_nType;                // KE_SERVERTYPE, set by KSOServer's ctor
    BOOL        m_bResult;
    int         m_nIndex;               // position in m_pClientConnections[]
    KSOServer*  m_pServer;
    KCONNECTION m_sConnection;
    IClient*    m_pClient;
    char        m_szConnection[64];
    KSG_LogFile m_cLogFile;

private:
    CClientConnection(const CClientConnection&);
    CClientConnection& operator=(const CClientConnection&);
};

// ---------------------------------------------------------------------------
// A link that proves itself with a heartbeat instead of trusting TCP.
//
// Every 3 seconds it sends a 10-byte RELAY_PING (family 15, id 43) and expects
// the same 10 bytes back; a reply inside 1 second sets m_bIsSafety. TCP will
// happily hold a connection open to a peer that has stopped answering, and for
// the tong server -- which the game blocks on -- that is worse than a clean
// disconnect.
//
// Only CTongConnection uses it. The class is separate because the shipped tree
// has it separate, and because the next link that needs a heartbeat inherits it
// for free.
// ---------------------------------------------------------------------------
class CClientPingConnection : public CClientConnection
{
public:
    explicit CClientPingConnection(LPCSTR pszConnection);

    void ConnectionResult(BOOL bResult);                                // [2]
    BOOL TranslateMessage(void* pMsg, int size);                        // [4]
    void ApplyCheckSafety();                                            // [6]

    virtual BOOL IsSafety();                                            // [9]

protected:
    DWORD m_dwLastPing;      // when a reply last arrived
    DWORD m_dwStartPing;     // when the outstanding ping went out
    BOOL  m_bIsSafety;
    DWORD m_dwPingSequence;
};

class CDatabaseConnection : public CClientConnection
{
public:
    CDatabaseConnection() : CClientConnection("Goddess") {}
};

class CGatewayConnection : public CClientConnection
{
public:
    CGatewayConnection() : CClientConnection("Bishop") {}
};

class CTranConnection : public CClientConnection
{
public:
    CTranConnection() : CClientConnection("Tran") {}
    BOOL IsPrime() { return 1; }
};

class CChatConnection : public CClientConnection
{
public:
    CChatConnection() : CClientConnection("Chat") {}

    // The only link the server outlives. Chat is the one service whose absence
    // costs a feature rather than the world state.
    BOOL IsPrime() { return 0; }
};

class CTongConnection : public CClientPingConnection
{
public:
    CTongConnection() : CClientPingConnection("Tong") {}
    BOOL IsPrime() { return 1; }
};

#endif  // JX_CORE_CLIENTCONNECTION_H
