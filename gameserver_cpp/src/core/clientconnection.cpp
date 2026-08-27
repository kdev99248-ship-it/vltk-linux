#include "clientconnection.h"

#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>

#include "interfaces.h"
#include "jx_protocol.h"
#include "jx_protocol_ids.h"
#include "ksoserver.h"

// The two events librainbow reports through the handler registered with
// RegisterEventHandler. Same numbers heaven uses on the inbound side.
static const int kEventConnectionCreate = 256;
static const int kEventConnectionClose  = 257;

// ---------------------------------------------------------------------------
// CClientConnection @ 0x0804D390.
//
// 0x200000 is a placeholder buffer size and is never the one used: Initialize
// overwrites m_sConnection wholesale from servercfg.ini before anything opens.
// It matters only if a link is opened without being configured, which would be
// a bug elsewhere.
// ---------------------------------------------------------------------------
CClientConnection::CClientConnection(LPCSTR pszConnection)
    : m_nType(0), m_bResult(0), m_nIndex(0), m_pServer(0), m_pClient(0),
      m_cLogFile(0)
{
    m_sConnection.szIp[0]  = 0;
    m_sConnection.nPort    = 0;
    m_sConnection.nBufSize = 0x200000;

    if (pszConnection)
    {
        strncpy(m_szConnection, pszConnection, 0x3Fu);
        m_szConnection[63] = 0;
    }
    else
    {
        m_szConnection[0] = 0;
    }
}

// @ 0x0804D260. Does not Close(). The shipped server drops the links through
// CloseClientConnections in UnInitialize and destroys the KSOServer afterwards,
// so by the time this runs m_pClient is already 0 -- and on the path where it
// is not, releasing an IClient while librainbow's thread may still be in the
// event handler is worse than leaking it.
CClientConnection::~CClientConnection()
{
}

// ---------------------------------------------------------------------------
// Open @ 0x0804D080.
// ---------------------------------------------------------------------------
BOOL CClientConnection::Open()
{
    if (!m_pClient)
    {
        if (!m_pServer->CreateClient(m_sConnection.nBufSize, &m_pClient) || !m_pClient)
        {
            // "rainbow.dll" -- the Windows name, in a Linux binary. Left as it
            // is because deployment notes and forum posts quote this line.
            puts("Initialization failed! Don't find a correct rainbow.dll");
            return 0;
        }

        printf("[%s]IP:%s, Port:%u\n", m_szConnection, m_sConnection.szIp,
               (unsigned)m_sConnection.nPort);
        m_pClient->RegisterEventHandler(this, CClientConnection::EventHandler);
    }

    // Binds the local end to the INTRANET address, not the internet one --
    // opposite to the listening socket in KSOServer::CreateServer, and correct:
    // the five peers are on the private side. A zero intranet address means
    // "let the kernel choose", so the call is skipped.
    if (m_pServer->GetIntranetIp())
        m_pClient->BindIp(m_pServer->GetIntranetIp());

    if (m_pClient->ConnectTo(inet_addr(m_sConnection.szIp),
                             (unsigned short)m_sConnection.nPort))
    {
        printf("Connect [%s] successful!\n", m_szConnection);

        CHAR szKey[272];
        snprintf(szKey, 0x104u, "Logs/conn_%s", m_szConnection);
        szKey[259] = 0;
        // bEveryDayChangeFile = 0: the date is stamped into the name once, at
        // connect time, and a link that stays up for a week keeps writing to
        // the file named after the day it dialled.
        m_cLogFile.InitWithDate(szKey, "log", 0);
        return 1;
    }

    printf("Connect to [%s] is failed!\n", m_szConnection);
    return 0;
}

// @ 0x0804CFD0.
void CClientConnection::Close()
{
    if (m_pClient)
    {
        printf("[%s] is closing...\n", m_szConnection);
        m_pClient->Shutdown();
        m_pClient->Release();
        m_pClient = 0;
    }
}

// @ 0x0804CF20.
BOOL CClientConnection::SendData(const void* pData, unsigned int nLen)
{
    if (!m_pClient)
        return 0;
    return m_pClient->SendPackToServer(pData, nLen) != 0;
}

// @ 0x0804CF60, where it is a tail call into IClient::GetPackFromServer.
const void* CClientConnection::RecvData(unsigned int& nLen)
{
    if (m_pClient)
        return m_pClient->GetPackFromServer(nLen);

    nLen = 0;
    return 0;
}

// ---------------------------------------------------------------------------
// ProcessMessages @ 0x0804CE80.
//
// ApplyCheckSafety runs first and unconditionally -- before the drain, and even
// on a tick with no traffic -- which is what lets the ping subclass keep time
// on a link that has gone quiet.
//
// The drain then empties the link completely rather than taking one packet per
// tick, and re-reads m_pClient and m_bResult every iteration: the event handler
// runs on librainbow's thread and can null the client out mid-loop.
// ---------------------------------------------------------------------------
void CClientConnection::ProcessMessages(IServerCore* pCore)
{
    if (!m_bResult)
        return;

    ApplyCheckSafety();

    while (m_pClient && m_bResult)
    {
        unsigned int leng = 0;
        void* pData = m_pClient->GetPackFromServer(leng);
        if (!pData || !leng)
            break;

        if (TranslateMessage(pData, (int)leng))
            pCore->ProcessServerMessage((KE_SERVERTYPE)m_nType, pData, leng);
    }
}

// ---------------------------------------------------------------------------
// EventHandler @ 0x0804D330. The cookie is the connection itself, registered in
// Open. Called from librainbow's thread, hence the lock.
// ---------------------------------------------------------------------------
void CClientConnection::EventHandler(void* pParam, int nEvent)
{
    CClientConnection* pThis = (CClientConnection*)pParam;

    pThis->m_pServer->Lock();
    if (nEvent == kEventConnectionCreate)
        pThis->OnConnectionCreate();
    else if (nEvent == kEventConnectionClose)
        pThis->OnConnectionClose();
    pThis->m_pServer->UnLock();
}

// @ 0x0804D060.
void CClientConnection::OnConnectionCreate()
{
    printf("connection[%s] create\n", m_szConnection);
}

// @ 0x0804D020. Exit() only sets m_bIsRunning to 0; the main loop notices on
// its next Breathe and shuts down in an orderly way, so this returns promptly
// and librainbow's thread is not held up.
void CClientConnection::OnConnectionClose()
{
    if (IsPrime())
        m_pServer->Exit();
    printf("connection[%s] lost\n", m_szConnection);
}

// ---------------------------------------------------------------------------
// The base virtuals. @ 0x0804CAB0, 0x0804CDA0, 0x0804CF10, 0x0804CAC0,
// 0x0804CAD0, 0x0804CF90, 0x0804CAE0.
// ---------------------------------------------------------------------------
void CClientConnection::ConnectionResult(BOOL bResult) { m_bResult = bResult; }
BOOL CClientConnection::IsPrime()                      { return 1; }
BOOL CClientConnection::TranslateMessage(void* pMsg, int size) { return 1; }
BOOL CClientConnection::ISafety()                      { return 1; }
void CClientConnection::ApplyCheckSafety()             { }
void CClientConnection::ProcessMessage(void* pMsg, int size) { }

void CClientConnection::WriteLog(LPCSTR pszLog)
{
    m_cLogFile.printf_t("%s\r\n", pszLog);
    puts(pszLog);
}

// ---------------------------------------------------------------------------
// CClientPingConnection @ 0x0804D4F0.
// ---------------------------------------------------------------------------
CClientPingConnection::CClientPingConnection(LPCSTR pszConnection)
    : CClientConnection(pszConnection),
      m_dwLastPing(0), m_dwStartPing(0), m_bIsSafety(0), m_dwPingSequence(0)
{
}

// @ 0x0804D590. Seeding m_dwLastPing at connect time is what keeps the first
// ApplyCheckSafety from declaring the fresh link unsafe.
void CClientPingConnection::ConnectionResult(BOOL bResult)
{
    m_bResult = bResult;
    m_dwLastPing = m_pServer->ElapseTime();
}

// @ 0x0804D420. The reply is consumed here and never reaches the core --
// returning 0 is the whole point of the filter slot.
BOOL CClientPingConnection::TranslateMessage(void* pMsg, int size)
{
    const BYTE* p = (const BYTE*)pMsg;
    if (size != (int)sizeof(RELAY_PING) ||
        p[0] != JX_FAMILY_RELAY_PING || p[1] != JX_SUBID_RELAY_PING)
    {
        return CClientConnection::TranslateMessage(pMsg, size);
    }

    // Round trip measured against the tick the ping was SENT, not against the
    // sequence number, so a reply to an older ping still counts -- the sequence
    // is carried for the peer's benefit and is not checked here.
    const DWORD dwNow = m_pServer->ElapseTime();
    const DWORD dwRoundTrip = dwNow - m_dwStartPing;
    m_dwLastPing = dwNow;
    m_bIsSafety = (dwRoundTrip <= 1000);
    return 0;
}

// ---------------------------------------------------------------------------
// ApplyCheckSafety @ 0x0804D5B0. One ping every 3 seconds.
//
// The unsafe test is `m_dwStartPing > m_dwLastPing`, i.e. "the last ping went
// out after the last reply came in" -- an outstanding ping that has now been
// waiting the full 3 seconds. It is checked before the new ping is sent, so the
// verdict is always about the previous round.
// ---------------------------------------------------------------------------
void CClientPingConnection::ApplyCheckSafety()
{
    if (m_pServer->ElapseTime() - m_dwStartPing <= 3000)
        return;

    if (m_dwStartPing > m_dwLastPing)
        m_bIsSafety = 0;

    if (!m_pClient)
        return;

    RELAY_PING msg;
    msg.ProtocolFamily = JX_FAMILY_RELAY_PING;
    msg.ProtocolID     = JX_SUBID_RELAY_PING;
    msg.dwSequence     = m_dwPingSequence++;
    msg.dwTimestamp    = m_pServer->ElapseTime();
    m_pClient->SendPackToServer(&msg, sizeof(msg));

    m_dwStartPing = m_pServer->ElapseTime();
}

// @ 0x0804CCB0.
BOOL CClientPingConnection::IsSafety() { return m_bIsSafety; }
