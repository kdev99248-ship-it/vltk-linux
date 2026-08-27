// KSOServer -- the process half of the server: config, sockets, the clock.
//
// It implements IGameServer, owns the two loaded libraries and the IServer that
// libheaven.so hands back, and runs the main loop. It knows nothing about the
// game; everything that arrives from a client is handed to IServerCore, and
// everything the core sends goes back out through the IServer here.
//
// The clock is worth reading before the code. There are two counters running at
// different rates and they are not interchangeable:
//
//     m_dwElapseTime   milliseconds since startup
//     m_dwElapseTick   144ths of a second since startup
//
// and one target, m_dwGameTick, which advances by 8 per game loop. 144/8 is 18,
// so the server runs at 18 game loops per second, and m_nGameFPS is the loop
// count measured back against real time -- 18 when it is keeping up.
//
// Recovered from _ZTV9KSOServer @ 0x082492C0 and the DWARF layout of KSOServer
// (3532 bytes).
#ifndef JX_CORE_KSOSERVER_H
#define JX_CORE_KSOSERVER_H

#include "clientconnection.h"
#include "heaven_abi.h"
#include "interfaces.h"
#include "kcoder2.h"
#include "threadlock.h"
#include "windows.h"

class KIniFile;

class KSOServer : public IGameServer
{
public:
    KSOServer();
    ~KSOServer();

    BOOL Initialize(int nPort, BOOL bOpenGm);
    void UnInitialize();
    void Run();

    // IGameServer, in vtable order.
    void   Exit();
    BOOL   SendDataToClient(unsigned long nId, const void* pData, unsigned int nLen);
    BOOL   SendDataToServer(KE_SERVERTYPE nType, const void* pData, unsigned int nLen);
    void   ShutdownClient(unsigned long nId);
    LPCSTR GetClientInfo(unsigned long nId);
    const void* RecvGoddessMessage(unsigned int& nLen);
    unsigned long GetInternetIp() const;
    unsigned long GetIntranetIp() const;
    int    GetPort() const;
    LPCSTR GetBishopClientIp() const;

    // Called by CClientConnection, which runs partly on librainbow's thread.
    // Lock/UnLock guard the same section MessageLoop and Breathe take, so a
    // link going down cannot land in the middle of a game tick.
    void Lock();
    void UnLock();
    BOOL CreateClient(int nBufLen, IClient** ppClient);

    // The ping subclass times its heartbeat against the server's own clock
    // rather than calling gettimeofday again -- one clock, one answer per tick.
    DWORD ElapseTime() const { return m_dwElapseTime; }

private:
    BOOL Loop();
    void MessageLoop();
    BOOL Breathe();
    void ProcessClientMessages();
    void ProcessPlayerMessages();

    BOOL CreateServer();
    BOOL CreateCore(IServerCore** ppCore, int nMaxPlayerCount, BOOL bOpenGm);
    BOOL CreateClientConnections();
    void CloseClientConnections();

    void LoadConnection(KIniFile* pIni, LPCSTR pszSection, KCONNECTION* pConnection);
    BOOL GetLocalIpAddress(DWORD* pIntranetAddr, DWORD* pInternetAddr);

    // heaven calls this from its own thread, hence the lock and hence the
    // static: it is a C function pointer plus a cookie, not a virtual.
    static void ServerEventNotify(void* pContext, unsigned int nId, int nEvent);
    void EventNotify(unsigned int nId, int nEvent);

    // The five links, owned by value, plus an array over them. Declaration
    // order is construction order and is the shipped one.
    //
    // m_pClientConnections is NOT in KE_SERVERTYPE order and is not indexed by
    // it -- it is the iteration order, and it puts the gateway last so that the
    // link the rest of the stack waits on is the last one dialled. Index by
    // m_nIndex; switch on m_nType. SendDataToServer therefore switches rather
    // than subscripting, exactly as the original does.
    CClientConnection*  m_pClientConnections[emSERVER_COUNT];
    CDatabaseConnection m_connDatabase;
    CGatewayConnection  m_connGateway;
    CChatConnection     m_connChat;
    CTongConnection     m_connTong;
    CTranConnection     m_connTran;

    DWORD        m_dwElapseTime;
    DWORD        m_dwOriginTime;
    DWORD        m_dwOriginTick;
    DWORD        m_dwElapseTick;
    DWORD        m_dwGameTick;
    DWORD        m_dwGameLoop;
    int          m_nGameFPS;

    DWORD        m_nInternetIp;
    DWORD        m_nIntranetIp;

    KThreadLock  m_cLock;
    KCoder2      m_cCoder;
    KRainbowLib  m_cClientLib;
    KHeavenLib   m_cServerLib;

    int          m_nMaxPlayer;
    int          m_nServerPort;
    BOOL         m_bIsRunning;

    IServer*     m_pServer;
    IServerCore* m_pServerCore;
};

#endif  // JX_CORE_KSOSERVER_H
