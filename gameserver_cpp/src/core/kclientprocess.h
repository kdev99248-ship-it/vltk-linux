// KClientProcess -- everything a connected player's socket says to the server.
//
// One instance, not one per client: the client id is an argument. It is the
// only one of the six protocol processors on the Phase 1 path, because it is
// the only one facing the game client rather than one of the five outbound
// server links.
//
// The state machine lives in ProcessMessage and is the reason a session works
// at all; see GameStatus in kservercore.h for what the four states mean.
#ifndef JX_CORE_KCLIENTPROCESS_H
#define JX_CORE_KCLIENTPROCESS_H

#include "interfaces.h"
#include "windows.h"

class KServerCore;

class KClientProcess
{
public:
    explicit KClientProcess(BOOL bOpenGm);

    void Initialize(IGameServer* pServer, KServerCore* pCore);

    // The whole inbound path. Size-gates first, then dispatches on the
    // session's state. A message that fails the gate disconnects the client.
    void ProcessMessage(unsigned int nId, const void* pData, size_t nLen);

private:
    // State 0. THE handshake: exactly 17 bytes, protocol 66
    // (c2s_logiclogin), payload a 16-byte GUID naming the character this
    // connection is claiming. Returns the player index, or 0 to reject.
    int  ProcessLoginProtocol(unsigned int nId, const void* pData, size_t nLen);

    // State 2 -> 3. Nine bytes, protocol 67 (c2s_syncend).
    BOOL ProcessSyncReplyProtocol(unsigned int nId, int nPlayerIndex,
                                  const char* pData, size_t nLen);

    // State 3. Protocol 0x70, nine bytes, and the echoed DWORD has to match
    // what PingClient recorded or the client is dropped.
    void ProcessPingReply(unsigned int nId, const char* pData, size_t nLen);

    // Loads the character and tells the client to start syncing. Phase 2.
    BOOL SendGameDataToClient(unsigned int nId, int nPlayerIndex);

    // Cross-server relay ("trip"). Phase 2.
    BOOL ProcessRelayMsg(unsigned int nId, int nPlayerIndex,
                         const char* pData, size_t nLen);

    IGameServer* m_pServer;
    KServerCore* m_pCore;
    BOOL         m_bOpenGm;
};

#endif  // JX_CORE_KCLIENTPROCESS_H
