// The ABI of the two network libraries the game server loads at run time.
//
// The game server owns no socket code. libheaven.so is the server side -- it
// listens, accepts, buffers and decodes -- and librainbow.so is the client side,
// used for the five outbound links to gateway/database/transfer/chat/tong. Both
// ship as ELF32 i386 objects with no headers, which is also why this whole port
// has to be 32-bit.
//
// Nothing below came from a header, because there is none. These are
// transcriptions of the vtables in the shipped .so files:
//
//   * the slot ORDER is the ABI, fixed by _ZTV7IServer (64 bytes = 14 slots),
//     _ZTV7IClient (40 = 8), _ZTV14IClientManager (24 = 4) and _ZTV7KCoder2
//     in jx_linux_y (2);
//   * each slot's parameter list is the Itanium mangling of the KServer /
//     KClient / KClientManager method that fills it, so it is read rather than
//     guessed:
//
//         _ZN7KServer11OpenServiceEjt
//             -> KServer::OpenService(unsigned int, unsigned short)
//         _ZN7KServer17GetPackFromClientEjRj
//             -> KServer::GetPackFromClient(unsigned int, unsigned int&)
//         _ZN14KClientManager12CreateClientEjPP7IClientP6ICoder
//             -> KClientManager::CreateClient(unsigned int, IClient**, ICoder*)
//
//   * return types are the one thing mangling does not encode. They come from
//     the call sites in jx_linux_y -- `if (pServer->Initialize())` makes that
//     slot a BOOL, GetPackFromClient's result is dereferenced as a buffer -- and
//     a slot the server never calls is declared void, which is safe on i386
//     because the caller simply ignores EAX.
//
// Three properties of the declarations below are load-bearing:
//
//   * declaration order IS slot order. Do not reorder and do not insert.
//   * no virtual destructor anywhere. Slot 0 is Release(); GCC would put the
//     two destructor slots first and shift every other slot by one.
//   * the default i386 C++ calling convention is cdecl with `this` as a stack
//     argument, which is what GCC used to build both libraries. This is not
//     MSVC thiscall, so no attribute is needed -- but it is a reason a 64-bit
//     or non-GCC build of this file would not interoperate.
#ifndef JX_NET_HEAVEN_ABI_H
#define JX_NET_HEAVEN_ABI_H

#include "windows.h"

struct ICoder;
struct INetworkLog;

// ---------------------------------------------------------------------------
// ICoder -- the wire cipher, called BY heaven on every packet in both
// directions. The server registers one with IServer::RegisterCoder and heaven
// then owns the calls. See kcoder2.h for the implementation the server passes.
//
// nKey is by value: heaven supplies the key per packet and does not expect it
// back, which is what makes the cipher stateless per call.
// ---------------------------------------------------------------------------
struct ICoder
{
    virtual void Encode(void* pData, unsigned int nLen, unsigned int nKey) = 0;
    virtual void Decode(void* pData, unsigned int nLen, unsigned int nKey) = 0;
};

// ---------------------------------------------------------------------------
// IServer -- libheaven.so. Implemented there by KServer.
//
// The event handler is a plain function pointer plus an opaque cookie, not a
// virtual: heaven calls handler(cookie, nClientId, nEvent) from its own thread.
// The two events the server acts on are 256 (client created) and 257 (client
// closed); see KSOServer::EventNotify.
// ---------------------------------------------------------------------------
struct IServer
{
    virtual void  Release() = 0;                                        // [ 0]
    virtual BOOL  Initialize() = 0;                                     // [ 1]
    virtual void  UnInitialize() = 0;                                   // [ 2]
    virtual BOOL  OpenService(unsigned int uAddr,
                              unsigned short uPort) = 0;                // [ 3]
    virtual void  CloseService() = 0;                                   // [ 4]
    virtual void  RegisterEventHandler(
        void* pContext,
        void (*pfnHandler)(void*, unsigned int, int)) = 0;              // [ 5]
    virtual void  RegisterCoder(ICoder* pCoder) = 0;                    // [ 6]
    virtual BOOL  PackDataToClient(unsigned int nClientId,
                                   const void* pData,
                                   unsigned int nLen) = 0;              // [ 7]
    virtual BOOL  SendPackToClient(unsigned int nClientId) = 0;         // [ 8]
    virtual BOOL  SendData(unsigned int nClientId,
                           const void* pData,
                           unsigned int nLen) = 0;                      // [ 9]
    virtual void* GetPackFromClient(unsigned int nClientId,
                                    unsigned int& nLen) = 0;            // [10]
    virtual BOOL  ShutdownClient(unsigned int nClientId) = 0;           // [11]
    virtual unsigned int GetClientCount() = 0;                          // [12]
    virtual LPCSTR GetClientInfo(unsigned int nClientId) = 0;           // [13]
};

// ---------------------------------------------------------------------------
// IClient / IClientManager -- librainbow.so. Implemented there by KClient and
// KClientManager. One IClient per outbound link.
// ---------------------------------------------------------------------------
struct IClient
{
    virtual void  Release() = 0;                                        // [0]
    virtual void  Shutdown() = 0;                                       // [1]
    virtual BOOL  ConnectTo(unsigned int uAddr, unsigned short uPort) = 0;  // [2]
    virtual void  RegisterEventHandler(
        void* pContext, void (*pfnHandler)(void*, int)) = 0;            // [3]
    virtual BOOL  SendPackToServer(const void* pData,
                                   unsigned int nLen) = 0;              // [4]
    virtual void* GetPackFromServer(unsigned int& nLen) = 0;            // [5]
    virtual void  BindIp(unsigned int uAddr) = 0;                       // [6]
    virtual void  SetLog(INetworkLog* pLog) = 0;                        // [7]
};

struct IClientManager
{
    virtual void Release() = 0;                                         // [0]
    virtual BOOL Initialize() = 0;                                      // [1]
    virtual void UnInitialize() = 0;                                    // [2]
    virtual BOOL CreateClient(unsigned int nBufSize,
                              IClient** ppClient,
                              ICoder* pCoder) = 0;                      // [3]
};

// The two exported factories, the only C symbols either library provides:
//
//     libheaven.so :  CreateServer
//     librainbow.so:  CreateClientManager
//
// Both are `extern "C"` in the shipped objects -- the symbol names are
// unmangled in .dynsym -- so these signatures are what dlsym hands back.
typedef BOOL (*PFN_CreateServer)(unsigned int nMaxClient,
                                 unsigned int nBufSize,
                                 IServer** ppServer);
typedef BOOL (*PFN_CreateClientManager)(int nMaxClient,
                                        IClientManager** ppManager);

// ---------------------------------------------------------------------------
// The dlopen wrappers. The shipped server builds the file name at run time --
// snprintf("./lib%s.so", "heaven") -- so the libraries are looked up in the
// current directory and nowhere else, deliberately: the deployed tree keeps its
// own copies next to the binary. Reproduced rather than "fixed", because a
// server that found a different libheaven.so through LD_LIBRARY_PATH would be a
// different server.
// ---------------------------------------------------------------------------
class KDll
{
public:
    KDll() : m_hDll(0) {}
    ~KDll() { Unload(); }

    bool  Load(LPCSTR pszName);      // pszName is "heaven", not a path
    void  Unload();
    void* Symbol(LPCSTR pszSymbol) const;
    bool  IsLoaded() const { return m_hDll != 0; }

private:
    KDll(const KDll&);
    KDll& operator=(const KDll&);

    void* m_hDll;
};

class KHeavenLib
{
public:
    KHeavenLib() : m_pfnCreate(0) {}

    // Loads ./libheaven.so and resolves CreateServer. Prints the same message
    // the original does on failure, because startup output is compared against
    // the oracle.
    bool Load();
    void Unload() { m_pfnCreate = 0; m_cDll.Unload(); }

    PFN_CreateServer Create() const { return m_pfnCreate; }

private:
    KDll             m_cDll;
    PFN_CreateServer m_pfnCreate;
};

class KRainbowLib
{
public:
    KRainbowLib() : m_pClientManager(0) {}

    // Loads ./librainbow.so, resolves CreateClientManager, creates the manager
    // with the shipped argument (6) and initialises it.
    bool Load();
    void Unload();

    IClientManager* Manager() const { return m_pClientManager; }

private:
    KDll            m_cDll;
    IClientManager* m_pClientManager;
};

#endif  // JX_NET_HEAVEN_ABI_H
