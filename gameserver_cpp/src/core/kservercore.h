// KServerCore -- the game half of the server.
//
// It owns one GameStatus per client slot and the six protocol processors, and
// it never touches a socket: everything it sends goes back out through the
// IGameServer it was handed at Initialize.
//
// SCOPE. This is the Phase 1 slice: the path a connecting client actually
// walks, from accept to the login protocol, plus the clock the loop drives.
// Members and methods the shipped class has that this path does not reach are
// NOT declared here -- see docs/PHASE1.md for the list and for why an empty
// player set makes the login return 0 in the original too, which is what keeps
// the oracle comparison meaningful this early.
//
// Recovered from _ZTV11KServerCore @ 0x0824A5E0 and the DWARF layout of
// KServerCore (65628 bytes) and GameStatus (48).
#ifndef JX_CORE_KSERVERCORE_H
#define JX_CORE_KSERVERCORE_H

#include "interfaces.h"
#include "windows.h"

class KClientProcess;

// Per-connection session state, indexed by the client id heaven assigns --
// which is a slot number in [0, m_nMaxPlayerCount), not a handle.
//
// nGameStatus is the state machine KClientProcess::ProcessMessage switches on,
// and the four values are the whole client lifecycle:
//
//     0  connected, waiting for the 17-byte c2s_logiclogin
//     1  login was accepted but the character could not be loaded -- a dead
//        end; the connection stays up and nothing more is dispatched
//     2  character loaded, waiting for the client's 9-byte sync reply
//     3  in the world
//
// nNetStatus is the gate ProcessClientMessage checks: 1 between OnClientCreate
// and OnClientClose, 0 otherwise, so packets that arrive for a slot heaven has
// already recycled are dropped rather than dispatched at the previous
// occupant's session.
struct GameStatus
{
    int   nPlayerIndex;
    int   nGameStatus;
    int   nNetStatus;
    int   nExchangeStatus;
    DWORD dwSendPingTime;
    DWORD dwReplyPingTime;

    // The shipped struct has a CHANNEL_MSGTIME map here (offset 24, taking the
    // struct to 48 bytes) holding the last time this client spoke on each chat
    // channel, for flood control. Deliberately absent rather than guessed at:
    // nothing in the Phase 1 path reads it, and GameStatus never crosses a
    // process boundary, so its size is not part of any contract.
};

class KServerCore : public IServerCore
{
public:
    KServerCore(int nMaxPlayerCount, BOOL bOpenGm);
    ~KServerCore();

    // IServerCore, in vtable order.
    BOOL Initialize(IGameServer* pGameServer, IServer* pNetServer);
    void UnInitialize();
    void Exit();
    void Release();
    void MessageLoop();
    void Breathe(unsigned long dwGameLoop, unsigned long dwElapseTime, int nGameFPS);
    void ProcessServerMessage(KE_SERVERTYPE nType, const void* pData, unsigned int nLen);
    void ProcessClientMessage(unsigned int nId, const void* pData, unsigned int nLen);
    void OnClientCreate(unsigned long nId);
    void OnClientClose(unsigned long nId);

    // Every inbound byte passes through this before anything looks at it. A
    // length that does not match the table disconnects the sender, so the table
    // is part of the wire format -- it lives in src/protocol/jx_protocol_ids.h
    // as jx_c2s_protocol_size[], generated from the shipped initialiser.
    BOOL CheckProtocolSize(int nPlayerIndex, const char* pChar, int nSize,
                           BOOL* pbShutDown);

    // Matches a connecting client to an already-loaded character by GUID.
    // Returns the player index, or 0 for no match -- 0 is "none", not a valid
    // index.
    int AttachPlayer(unsigned long nId, const GUID* pGuid);

    // Starts a ping round trip: sends 0x82 with the current game loop and
    // records it, so ProcessPingReply can check the echo.
    void PingClient(unsigned long nId);

    // The shipped accessor the protocol processors read player state through --
    // one function with a switch on nType (3 = account name, 0 = role name, ...).
    // Phase 2; see the definition.
    int GetGameData(unsigned int nType, unsigned int nParam1, int nParam2);

    GameStatus* Status(unsigned int nId) { return &m_pGameStatus[nId]; }
    IGameServer* Server() const { return m_pServer; }
    DWORD GameLoop() const { return m_dwGameLoop; }
    int MaxPlayerCount() const { return m_nMaxPlayerCount; }

private:
    void InitConnectionStatus(GameStatus* pStatus, int nStatus);
    void CleanConnectionStatus(unsigned long nId);

    GameStatus*  m_pGameStatus;
    DWORD        m_dwGameLoop;
    DWORD        m_dwTickCount;
    int          m_nMaxPlayerCount;
    IGameServer* m_pServer;

    // Of the six protocol processors the shipped core creates -- goddess,
    // bishop, host, tong, chat, client -- only the client-facing one is on the
    // Phase 1 path. The other five handle the inbound half of the five outbound
    // links, which Phase 1 does not open.
    KClientProcess* m_pClientProto;
};

#endif  // JX_CORE_KSERVERCORE_H
