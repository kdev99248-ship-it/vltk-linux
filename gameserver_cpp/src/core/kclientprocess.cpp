#include "kclientprocess.h"

#include <stdio.h>
#include <string.h>

#include "jx_protocol.h"
#include "jx_protocol_ids.h"
#include "kservercore.h"

KClientProcess::KClientProcess(BOOL bOpenGm)
    : m_pServer(0), m_pCore(0), m_bOpenGm(bOpenGm)
{
}

void KClientProcess::Initialize(IGameServer* pServer, KServerCore* pCore)
{
    m_pServer = pServer;
    m_pCore   = pCore;
}

// ---------------------------------------------------------------------------
// ProcessMessage @ 0x081F74F0.
//
// Both fields are read out of GameStatus before anything else runs, because the
// handlers below write them: case 0 changes nGameStatus and nPlayerIndex on the
// way out, and the switch has to have been taken on the state the message
// arrived in.
// ---------------------------------------------------------------------------
void KClientProcess::ProcessMessage(unsigned int nId, const void* pData, size_t nLen)
{
    GameStatus* pStatus = m_pCore->Status(nId);
    const int nPlayerIndex = pStatus->nPlayerIndex;
    const int nGameStatus  = pStatus->nGameStatus;

    BOOL bShutDown = 0;
    if (!m_pCore->CheckProtocolSize(nPlayerIndex, (const char*)pData, (int)nLen,
                                    &bShutDown))
    {
        if (!bShutDown)
            return;

        // A client that sends a malformed protocol gets its ACCOUNT locked for
        // five minutes, not just disconnected -- the assumption being that a
        // wrong length means a modified client rather than a bad network. The
        // lock only goes out if the connection had got far enough to have an
        // account name against it.
        TLockAccount lock;
        lock.cProtocol     = (BYTE)0x9D;   // -99 as a signed char
        lock.szAccount[0]  = 0;
        lock.dwTimeout     = 300;
        m_pCore->GetGameData(3, (unsigned int)(uintptr_t)lock.szAccount, nPlayerIndex);
        if (lock.szAccount[0])
        {
            lock.szAccount[31] = 0;
            m_pServer->SendDataToServer(emSERVER_BISHOP, &lock, 37);
        }

        char szLog[256];
        LPCSTR pszIp = m_pServer->GetClientInfo(nId);
        if (!pszIp)
            pszIp = "null";
        snprintf(szLog, 0xFF,
                 "[ShutdownClient]\tshut down client(%lu) - ip(%s) because invalid protocol!\n",
                 (unsigned long)nId, pszIp);
        szLog[255] = 0;
        printf("%s", szLog);

        m_pServer->ShutdownClient(nId);
        return;
    }

    // GetGameData(0x32, ...) asks whether this player is mid-relay to another
    // server; if so the message belongs to the relay, not to the state machine.
    if (m_pCore->GetGameData(0x32, nPlayerIndex, 0))
        return;
    if (ProcessRelayMsg(nId, nPlayerIndex, (const char*)pData, nLen))
        return;

    switch (nGameStatus)
    {
    case 0:
    {
        const int nIndex = ProcessLoginProtocol(nId, pData, nLen);
        if (!nIndex)
            break;

        if (SendGameDataToClient(nId, nIndex))
        {
            pStatus->nGameStatus = 2;
        }
        else
        {
            // Phase 2: NotifyHostLeaveGame(account, role, 3) before parking the
            // session. State 1 is terminal -- no case below handles it, so the
            // connection stays open and inert until the client drops it.
            pStatus->nGameStatus = 1;
        }
        pStatus->nPlayerIndex = nIndex;
        break;
    }

    case 2:
        if (ProcessSyncReplyProtocol(nId, nPlayerIndex, (const char*)pData, nLen))
        {
            pStatus->nGameStatus = 3;
            m_pCore->PingClient(nId);

            // Phase 2: tell the database the account entered the game
            // (tagEnterGame, protocol 52, 33 bytes, unless GetGameData(8)
            // says it is already there), NotifyHostEnterGame, and lock the
            // role at the gateway (tagRoleEnterGame, protocol 61, 34 bytes).
        }
        break;

    case 3:
        if (nPlayerIndex)
        {
            const BYTE byProtocol = *(const BYTE*)pData;
            if (byProtocol == 0x70)
            {
                ProcessPingReply(nId, (const char*)pData, nLen);
            }
            else if (byProtocol == 0xFD)
            {
                // Phase 2: ProcessPlayerTongMsg
            }
            else
            {
                // Phase 2: KPlayerSet::ProcessClientMessage -- the game
            }
        }
        break;

    default:
        break;
    }
}

// ---------------------------------------------------------------------------
// ProcessLoginProtocol @ 0x081F5FD0. THE handshake.
//
// Seventeen bytes: protocol 66 and a 16-byte GUID. That is the entire inbound
// login -- no account name, no password, no key exchange. Those happened at the
// gateway, which loaded the character into this server's player set and gave
// the client the GUID to present here; this message is the client saying which
// of the already-loaded characters it is.
//
// Worth stating plainly because it is easy to expect otherwise: this is NOT the
// 42-byte ACCOUNT_BEGIN handshake. That one belongs to the relay/paysys link.
// What the two share is the KSG cipher, nothing else.
//
// The clamp on the return value is in the original: a negative index from
// AttachPlayer becomes 0 rather than being propagated as a player.
// ---------------------------------------------------------------------------
int KClientProcess::ProcessLoginProtocol(unsigned int nId, const void* pData, size_t nLen)
{
    if (nLen != 17 || *(const BYTE*)pData != (BYTE)c2s_logiclogin)
        return 0;

    GUID guid;
    memcpy(&guid, (const char*)pData + 1, sizeof(GUID));

    const int nIndex = m_pCore->AttachPlayer(nId, &guid);
    return nIndex & ~(nIndex >> 31);
}

// ---------------------------------------------------------------------------
// ProcessSyncReplyProtocol @ 0x081F5D50.
// ---------------------------------------------------------------------------
BOOL KClientProcess::ProcessSyncReplyProtocol(unsigned int nId, int nPlayerIndex,
                                              const char* pData, size_t nLen)
{
    (void)nId;
    (void)nPlayerIndex;

    if (nLen != 9 || *(const BYTE*)pData != (BYTE)c2s_syncend)
        return 0;

    // The shipped version calls AddPlayerToWorld(nPlayerIndex, *(DWORD*)(pData+1),
    // *(DWORD*)(pData+5)) and then returns 1 unconditionally. Phase 2 -- and
    // returning 0 until then is the honest answer, because 1 would move the
    // session to "in the world" with nothing in it.
    return 0;
}

// ---------------------------------------------------------------------------
// ProcessPingReply @ 0x081F5C60.
//
// Nine bytes: 0x70, the DWORD PingClient sent, and a DWORD of the client's own
// that is echoed straight back in a five-byte 0x99. An unexpected value in the
// first DWORD drops the client -- it means the reply does not belong to the
// ping that is outstanding.
// ---------------------------------------------------------------------------
void KClientProcess::ProcessPingReply(unsigned int nId, const char* pData, size_t nLen)
{
    const char* pszReason = 0;

    if (nLen != 9)
    {
        pszReason = "[ShutdownClient]\tping cmd size not correct, may be Non-offical Client(%lu)...\n";
    }
    else
    {
        DWORD dwSent;
        memcpy(&dwSent, pData + 1, 4);
        if (dwSent != m_pCore->Status(nId)->dwSendPingTime)
            pszReason = "[ShutdownClient]\twrong time in ping cmd content, kill it(%lu)...\n";
    }

    if (pszReason)
    {
        char szLog[256];
        snprintf(szLog, 0xFF, pszReason, (unsigned long)nId);
        szLog[255] = 0;
        printf("%s", szLog);
        m_pServer->ShutdownClient(nId);
        return;
    }

    m_pCore->Status(nId)->dwReplyPingTime = m_pCore->GameLoop();

    PING_COMMAND pc;
    pc.cProtocol = (BYTE)0x99;
    memcpy(&pc.m_dwTime, pData + 5, 4);
    m_pServer->SendDataToClient(nId, &pc, 5);
}

// ---------------------------------------------------------------------------
// SendGameDataToClient @ 0x081F5DA0.
//
// The shipped version drives PlayerDbLoading through seven steps, then sets the
// session to state 2 and sends a one-byte 67 (c2s_syncend) telling the client
// to start syncing. Without the database link there is no step 0, so this
// reports the same failure the original reports when a load fails -- which is
// also the truth here.
//
// Unreachable in Phase 1: AttachPlayer cannot return a player, so
// ProcessLoginProtocol never returns non-zero.
// ---------------------------------------------------------------------------
BOOL KClientProcess::SendGameDataToClient(unsigned int nId, int nPlayerIndex)
{
    (void)nPlayerIndex;
    puts("PlayerDbLoading failed.");
    m_pServer->ShutdownClient(nId);
    return 0;
}

BOOL KClientProcess::ProcessRelayMsg(unsigned int nId, int nPlayerIndex,
                                     const char* pData, size_t nLen)
{
    (void)nId; (void)nPlayerIndex; (void)pData; (void)nLen;
    return 0;   // Phase 2: the cross-server relay
}
