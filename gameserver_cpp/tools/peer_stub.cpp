// peer_stub -- a real libheaven.so listener standing in for one of the five
// outbound peers.
//
//     ./peer_stub <port> [seconds]        (default 46005, 20)
//
// Run it next to libheaven.so, point one of the gameserver's [Gateway] /
// [Database] / [Transfer] / [Chat] / [Tong] sections at its port, and it prints
// every packet that link sends, decoded.
//
// A socket that only accepts is not a peer, and that is the reason this exists.
// librainbow completes its own key handshake (KClientManager::InitializeKey)
// before it flushes anything the application queued, so against an accept-only
// stub IClient::SendPackToServer returns 1 on every call and not one byte
// reaches the wire -- the link looks connected, the connection-create event
// fires, and the traffic is simply invisible. Using heaven as the peer makes the
// handshake happen by construction.
//
// It also registers the same KSG coder KHeavenLib installs, so what is printed
// is plaintext rather than ciphertext. That the two ends agree is a second,
// free check on the cipher.
//
// Built with:
//     cmake --build build --target peer_stub
#include <arpa/inet.h>
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "heaven_abi.h"
#include "ksg.h"
#include "windows.h"

// The interface heaven expects, filled in exactly as KHeavenLib fills it. The
// local key copy is the point of KSG_DecodeBuf/KSG_EncodeBuf: the cipher writes
// the advanced key back, and the caller's must survive that.
class KsgCoder : public ICoder
{
public:
    void Encode(void* pData, unsigned int nLen, unsigned int nKey)
    {
        unsigned int uKey = nKey;
        KSG_EncodeBuf(nLen, (unsigned char*)pData, &uKey);
    }

    void Decode(void* pData, unsigned int nLen, unsigned int nKey)
    {
        unsigned int uKey = nKey;
        KSG_DecodeBuf(nLen, (unsigned char*)pData, &uKey);
    }
};

// 256 = connection created, 257 = connection closed -- the same two numbers on
// both sides of the engine.
static void EventNotify(void* /*pContext*/, unsigned int nId, int nEvent)
{
    printf("[peer] client %u event %d\n", nId, nEvent);
    fflush(stdout);
}

int main(int argc, char** argv)
{
    const unsigned short uPort = (argc > 1) ? (unsigned short)atoi(argv[1]) : 46005;
    const int nSeconds = (argc > 2) ? atoi(argv[2]) : 20;

    // ./libheaven.so, not a search path -- the same lookup KDll does, so this
    // loads the copy sitting next to the binary under test and no other.
    void* hDll = dlopen("./libheaven.so", RTLD_NOW);
    if (!hDll)
    {
        printf("[peer] dlopen: %s\n", dlerror());
        return 1;
    }

    PFN_CreateServer pfnCreate = (PFN_CreateServer)dlsym(hDll, "CreateServer");
    if (!pfnCreate)
    {
        printf("[peer] librainbow has no CreateServer\n");
        return 1;
    }

    // Four client slots is plenty: one link connects, and the spare slots are
    // what the drain loop below sweeps.
    static const unsigned int kMaxClient = 4;

    IServer* pServer = 0;
    const BOOL bCreated = pfnCreate(kMaxClient, 204800u, &pServer);
    printf("[peer] CreateServer -> %d server=%p\n", (int)bCreated, (void*)pServer);
    if (!bCreated || !pServer)
        return 1;

    static KsgCoder coder;
    pServer->RegisterCoder(&coder);
    pServer->RegisterEventHandler(0, EventNotify);

    printf("[peer] Initialize -> %d\n", (int)pServer->Initialize());
    const BOOL bOpen = pServer->OpenService(inet_addr("127.0.0.1"), uPort);
    printf("[peer] OpenService(127.0.0.1:%u) -> %d\n", uPort, (int)bOpen);
    fflush(stdout);

    // Polled at 100 Hz, which is fast enough to time a 3-second heartbeat and
    // slow enough not to matter. Exiting the loop drops the link, which is also
    // how the gameserver's OnConnectionClose path gets exercised: give this a
    // shorter `seconds` than the run under test.
    for (int t = 0; t < nSeconds * 100; ++t)
    {
        for (unsigned int nId = 0; nId < kMaxClient; ++nId)
        {
            for (;;)
            {
                unsigned int nLen = 0;
                const unsigned char* pData =
                    (const unsigned char*)pServer->GetPackFromClient(nId, nLen);
                if (!pData || !nLen)
                    break;

                printf("[peer] <- client %u: %u bytes:", nId, nLen);
                for (unsigned int i = 0; i < nLen && i < 16; ++i)
                    printf(" %02x", pData[i]);
                if (nLen > 16)
                    printf(" ...");
                printf("\n");
                fflush(stdout);
            }
        }
        usleep(10000);
    }

    pServer->CloseService();
    pServer->UnInitialize();
    pServer->Release();
    return 0;
}
