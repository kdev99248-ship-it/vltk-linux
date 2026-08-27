#include "kservercore.h"

#include <stdio.h>
#include <string.h>

#include "jx_protocol.h"
#include "jx_protocol_ids.h"
#include "kclientprocess.h"

// ---------------------------------------------------------------------------
// CreateServerCore @ 0x08051550. Allocates, constructs, hands back the
// interface. The shipped version checks the result of operator new against
// null, which a modern toolchain cannot produce; the check is dropped rather
// than reproduced as dead code.
// ---------------------------------------------------------------------------
BOOL CreateServerCore(IServerCore** ppCore, int nMaxPlayerCount, BOOL bOpenGm)
{
    *ppCore = new KServerCore(nMaxPlayerCount, bOpenGm);
    return 1;
}

KServerCore::KServerCore(int nMaxPlayerCount, BOOL bOpenGm)
    : m_pGameStatus(0),
      m_dwGameLoop(0),
      m_dwTickCount(0),
      m_nMaxPlayerCount(nMaxPlayerCount),
      m_pServer(0),
      m_pClientProto(0)
{
    // One slot per client heaven can hand out, allocated up front and never
    // resized -- the client id IS the index, so the array has to cover the
    // whole range heaven was created with.
    m_pGameStatus = new GameStatus[nMaxPlayerCount];
    for (int i = 0; i < nMaxPlayerCount; ++i)
        InitConnectionStatus(&m_pGameStatus[i], 0);

    m_pClientProto = new KClientProcess(bOpenGm);
}

KServerCore::~KServerCore()
{
    delete m_pClientProto;
    delete[] m_pGameStatus;
}

BOOL KServerCore::Initialize(IGameServer* pGameServer, IServer* pNetServer)
{
    (void)pNetServer;   // the shipped code parks it in a global; nothing on the
                        // Phase 1 path reads it back
    m_pServer = pGameServer;
    m_pClientProto->Initialize(pGameServer, this);

    // What the shipped Initialize also does, all of it Phase 2: reads
    // settings/product_config.ini through the package VFS and sets the
    // region/language, prints the version banner, initialises the other five
    // protocol processors, opens the KGLog sinks and the tong/exception/
    // netevent/gameserver logs, creates the timer list, hooks the chat rooms,
    // reads settings/trip_config.ini for the relay mode, then g_InitCore and
    // KServerCore::OnLaunch -- which is where the world actually loads.
    return 1;
}

void KServerCore::UnInitialize()
{
}

void KServerCore::Exit()
{
}

// Release is how the object is destroyed -- IServerCore has no virtual
// destructor, and cannot gain one: slot 0 is Initialize, and GCC lays the two
// destructor slots out first, so adding one shifts every slot in the vtable.
//
// `delete this` is nonetheless well defined here, because the static type at
// the delete IS the most-derived type. GCC's warning fires on the class being
// polymorphic, not on this call being wrong, so it is silenced at exactly this
// statement rather than for the file.
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdelete-non-virtual-dtor"
void KServerCore::Release()
{
    delete this;
}
#pragma GCC diagnostic pop

void KServerCore::MessageLoop()
{
    // The shipped version flushes the four outbound message queues here
    // (g_NewProtocolProcess.SendNetMsgToChat / ToGateWay / ToTransfer /
    // ToTong). Nothing queues to them until the outbound links exist.
}

void KServerCore::Breathe(unsigned long dwGameLoop, unsigned long dwElapseTime,
                          int nGameFPS)
{
    (void)nGameFPS;
    m_dwGameLoop  = dwGameLoop;
    m_dwTickCount = dwElapseTime;

    // Phase 2: the world tick -- timers, players, npcs, scripts.
}

void KServerCore::ProcessServerMessage(KE_SERVERTYPE nType, const void* pData,
                                       unsigned int nLen)
{
    (void)nType; (void)pData; (void)nLen;
    // Phase 2: the inbound half of the five outbound links.
}

// ---------------------------------------------------------------------------
// ProcessClientMessage @ 0x0804DDE0.
//
// The nNetStatus test is not redundant with the range test. heaven runs its own
// thread and can queue a packet for a slot that has since closed; without the
// gate that packet would be dispatched at whatever session next occupies the
// slot.
// ---------------------------------------------------------------------------
void KServerCore::ProcessClientMessage(unsigned int nId, const void* pData,
                                       unsigned int nLen)
{
    if (nId < (unsigned int)m_nMaxPlayerCount && m_pGameStatus[nId].nNetStatus)
        m_pClientProto->ProcessMessage(nId, pData, nLen);
}

void KServerCore::OnClientCreate(unsigned long nId)
{
    if (nId < (unsigned long)m_nMaxPlayerCount && m_pGameStatus)
        InitConnectionStatus(&m_pGameStatus[nId], 1);
}

// ---------------------------------------------------------------------------
// OnClientClose @ 0x08053560.
//
// Everything inside the `nPlayerIndex > 0` guard is the leave-the-world path:
// work out whether the player got as far as the game world or only as far as
// login, tell the gateway and database, and drop the character. None of it is
// reachable while AttachPlayer cannot succeed, so it is left for Phase 2 --
// but the guard is real and stays, because it is what makes the rest of this
// function correct today.
// ---------------------------------------------------------------------------
void KServerCore::OnClientClose(unsigned long nId)
{
    if (nId >= (unsigned long)m_nMaxPlayerCount || !m_pGameStatus)
        return;

    if (m_pGameStatus[nId].nPlayerIndex > 0)
    {
        // Phase 2: GetLogoutType, then either ClientDisconnect (was in the
        // world) or NotifyGoddessLeaveGame + NotifyBishopLeaveGame /
        // RegisterExchangingLost followed by PreparePlayerForLoginFailed.
    }

    InitConnectionStatus(&m_pGameStatus[nId], 0);
}

void KServerCore::InitConnectionStatus(GameStatus* pStatus, int nStatus)
{
    pStatus->nGameStatus     = 0;
    pStatus->nPlayerIndex    = 0;
    pStatus->nExchangeStatus = 0;
    pStatus->dwReplyPingTime = 0;
    pStatus->dwSendPingTime  = 0;
    pStatus->nNetStatus      = nStatus;
}

void KServerCore::CleanConnectionStatus(unsigned long nId)
{
    InitConnectionStatus(&m_pGameStatus[nId], 0);
}

// ---------------------------------------------------------------------------
// CheckProtocolSize @ 0x08050280.
//
// The range test is written as one unsigned comparison in the original:
// (byte - 65) > 0xBC rejects everything outside [65, 253]. 0xBC is 188, the
// last index of the table, which is where the -65 shows up a second time.
//
// A protocol whose table entry is JX_C2S_VARIABLE takes its length from the
// packet: a WORD at offset 1 plus one for the protocol byte, and the message
// must be at least three bytes for that WORD to exist. An entry of 0 -- the
// 83 protocol bytes the initialiser never assigns -- matches no length at all
// and therefore always disconnects, which is the point: those bytes are not
// valid inbound protocols.
// ---------------------------------------------------------------------------
BOOL KServerCore::CheckProtocolSize(int nPlayerIndex, const char* pChar,
                                    int nSize, BOOL* pbShutDown)
{
    const unsigned char byProtocol = (unsigned char)*pChar;

    if ((unsigned char)(byProtocol - JX_C2S_FIRST_SIZED) >
        (unsigned char)(JX_C2S_LAST_SIZED - JX_C2S_FIRST_SIZED))
    {
        printf("[error]NetServer:Invalid Protocol!\n");
        *pbShutDown = 1;
        return 0;
    }

    const int nEntry = jx_c2s_protocol_size[byProtocol - JX_C2S_FIRST_SIZED];

    // The original truncates the table entry to 16 bits before comparing. No
    // entry is large enough for that to matter, but the comparison is the
    // contract, so it is reproduced rather than tidied.
    int nExpected = (int)(unsigned short)nEntry;
    bool bOk = false;

    if (nEntry == JX_C2S_VARIABLE)
    {
        nExpected = 0;
        if ((unsigned int)nSize > 2)
        {
            unsigned short wLen;
            memcpy(&wLen, pChar + 1, 2);
            nExpected = (int)(unsigned short)(wLen + 1);
            bOk = (nSize == nExpected);
        }
    }
    else
    {
        bOk = (nSize == nExpected);
    }

    if (!bOk)
    {
        // The shipped messages come from the localisation table
        // (L_CoreServerShell_0/1), which Phase 1 does not load; the shape of
        // the printf -- protocol, expected, actual -- is preserved.
        printf("[error]NetServer:Invalid Protocol Size! protocol(%d) expect(%d) actual(%d)\n",
               (int)byProtocol, nExpected, nSize);
        *pbShutDown = 1;
        return 0;
    }

    // The shipped tail rejects most protocols from a spectator, allowing only
    // the ones flagged in a per-protocol table. There are no spectators until
    // the world loads, so the test is constant-true here. Phase 2.
    (void)nPlayerIndex;
    return 1;
}

// ---------------------------------------------------------------------------
// AttachPlayer @ 0x0804EF10 -> KPlayerSet::AttachPlayer @ 0x080DD9A0.
//
// The shipped version walks KPlayerSet's in-use index looking for a character
// that is loaded, not already bound to a link, and whose GUID matches the 16
// bytes the client sent. The index is populated by the gateway/database path,
// so with none of that running it is empty and the walk returns 0 -- no match,
// login rejected, nothing sent back.
//
// That is also what this returns, which is the whole reason a Phase 1 oracle
// comparison is meaningful: run the shipped binary with no gateway and it
// accepts the connection, accepts the 17-byte packet, finds nothing and stays
// silent. Identical behaviour, for the same reason, is a real match rather
// than an accident.
// ---------------------------------------------------------------------------
int KServerCore::AttachPlayer(unsigned long nId, const GUID* pGuid)
{
    (void)nId; (void)pGuid;
    return 0;
}

// ---------------------------------------------------------------------------
// PingClient @ 0x0804DAA0. Five bytes: 0x82 and the current game loop. The
// value is recorded so ProcessPingReply can reject a reply that echoes the
// wrong one.
// ---------------------------------------------------------------------------
void KServerCore::PingClient(unsigned long nId)
{
    PING_COMMAND pc;
    pc.cProtocol = (BYTE)0x82;
    pc.m_dwTime  = m_dwGameLoop;

    m_pServer->SendDataToClient(nId, &pc, 5);

    m_pGameStatus[nId].dwReplyPingTime = 0;
    m_pGameStatus[nId].dwSendPingTime  = m_dwGameLoop;
}

int KServerCore::GetGameData(unsigned int nType, unsigned int nParam1, int nParam2)
{
    (void)nType; (void)nParam1; (void)nParam2;
    // Phase 2. Every caller on the Phase 1 path pre-zeroes the buffer it passes
    // and treats 0 / empty as "no such player", which is the correct answer
    // while the player set is empty.
    return 0;
}
