// The two interfaces the game server is built around, recovered from
// _ZTV9KSOServer @ 0x082492C0 and _ZTV11KServerCore @ 0x0824A5E0.
//
// They split the server in half, and the split is the reason the port can be
// staged:
//
//   IGameServer  is the process -- sockets, config, clock, the five outbound
//                links. Implemented by KSOServer. It knows nothing about the
//                game.
//   IServerCore  is the game -- session state, protocol dispatch, the world.
//                Implemented by KServerCore. It knows nothing about sockets;
//                everything it sends goes back out through IGameServer.
//
// As with heaven_abi.h, declaration order is vtable slot order and must not
// change, and neither interface has a virtual destructor: Release() is a slot
// (IServerCore[3]) and IGameServer has no teardown slot at all, because
// KSOServer owns itself.
//
// Signatures are the Itanium manglings of the KSOServer / KServerCore methods
// in each slot, e.g. _ZN11KServerCore7BreatheEmmi -> Breathe(unsigned long,
// unsigned long, int). `unsigned long` is 32-bit here and stays spelled that
// way rather than normalised to DWORD, so the mangling can be checked against
// the declaration by eye.
#ifndef JX_CORE_INTERFACES_H
#define JX_CORE_INTERFACES_H

#include "windows.h"

struct IServer;

// The five outbound links, in the order the enum in the binary's DWARF gives
// them. This is the argument to SendDataToServer and the tag
// ProcessServerMessage switches on, so the values are wire-relevant even though
// the enum never crosses a socket.
//
// The names are the shipped ones and they do not line up with the config
// sections: emSERVER_GODDESS reaches the [Database] connection and
// emSERVER_BISHOP the [Gateway] one -- see KSOServer::SendDataToServer, which
// is where the crossover is written down.
enum KE_SERVERTYPE
{
    emSERVER_GODDESS = 0,
    emSERVER_BISHOP  = 1,
    emSERVER_HOST    = 2,
    emSERVER_TONG    = 3,
    emSERVER_CHAT    = 4,
    emSERVER_COUNT   = 5,
};

struct IGameServer
{
    virtual void   Exit() = 0;                                          // [0]
    virtual BOOL   SendDataToClient(unsigned long nId,
                                    const void* pData,
                                    unsigned int nLen) = 0;             // [1]
    virtual BOOL   SendDataToServer(KE_SERVERTYPE nType,
                                    const void* pData,
                                    unsigned int nLen) = 0;             // [2]
    virtual void   ShutdownClient(unsigned long nId) = 0;               // [3]
    virtual LPCSTR GetClientInfo(unsigned long nId) = 0;                // [4]
    virtual const void* RecvGoddessMessage(unsigned int& nLen) = 0;     // [5]
    virtual unsigned long GetInternetIp() const = 0;                    // [6]
    virtual unsigned long GetIntranetIp() const = 0;                    // [7]
    virtual int    GetPort() const = 0;                                 // [8]
    virtual unsigned long GetBishopClientIp() const = 0;                // [9]
};

struct IServerCore
{
    virtual BOOL Initialize(IGameServer* pGameServer,
                            IServer* pNetServer) = 0;                   // [0]
    virtual void UnInitialize() = 0;                                    // [1]
    virtual void Exit() = 0;                                            // [2]
    virtual void Release() = 0;                                         // [3]
    virtual void MessageLoop() = 0;                                     // [4]
    virtual void Breathe(unsigned long dwGameLoop,
                         unsigned long dwElapseTime,
                         int nGameFPS) = 0;                             // [5]
    virtual void ProcessServerMessage(KE_SERVERTYPE nType,
                                      const void* pData,
                                      unsigned int nLen) = 0;           // [6]
    virtual void ProcessClientMessage(unsigned int nId,
                                      const void* pData,
                                      unsigned int nLen) = 0;           // [7]
    virtual void OnClientCreate(unsigned long nId) = 0;                 // [8]
    virtual void OnClientClose(unsigned long nId) = 0;                  // [9]
};

// The factory, `extern "C" CreateServerCore` @ 0x08051550. It lives in the same
// binary rather than in a library -- KSOServer::CreateCore is a one-line
// forwarder to it -- so the indirection buys nothing at run time. It is kept
// because it is the seam between the two halves above, and the port keeps the
// seam.
BOOL CreateServerCore(IServerCore** ppCore, int nMaxPlayerCount, BOOL bOpenGm);

#endif  // JX_CORE_INTERFACES_H
