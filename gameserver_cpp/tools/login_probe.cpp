// Drives a real login against the ported server, using the shipped client
// engine as the other half of the conversation.
//
// The point is that nothing here hand-rolls the wire format. librainbow.so is
// the client side of the same engine pair the game uses, so it frames, buffers
// and encrypts exactly as the real client does -- which means a session that
// works here is one the real client's transport would also have completed. The
// only piece supplied by this tree is KCoder2, and that is the piece under
// test: if the cipher or the table were wrong, heaven would decode garbage and
// the server would drop the connection on a protocol error.
//
//     ./login_probe 127.0.0.1 7666 [seconds] [bytes-to-send]
//
// Prints every event and every packet the server sends back. Exits 0 if the
// connection was established, whatever the server then decided to do with the
// login -- deciding is the server's job and the log says which way it went.
//
// The byte count exists for the negative test, and it is the sharper of the
// two. Send 16 bytes instead of 17 and a correctly decoding server answers
// with "protocol(66) expect(17) actual(16)" and drops the connection. Those
// exact numbers can only appear if the first byte arrived as 66 and the length
// survived, so they prove the cipher, the table and the size table together --
// where a silent, accepted login proves rather less.
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#include "heaven_abi.h"
#include "kcoder2.h"

static volatile int g_nLastEvent = -1;
static volatile int g_nEventCount = 0;

static void ClientEventNotify(void* pContext, int nEvent)
{
    (void)pContext;
    g_nLastEvent = nEvent;
    ++g_nEventCount;
    printf("[probe] client event %d\n", nEvent);
    fflush(stdout);
}

static void Hexdump(const char* pszTag, const unsigned char* p, unsigned int n)
{
    printf("[probe] %s %u bytes:", pszTag, n);
    for (unsigned int i = 0; i < n && i < 64; ++i)
        printf(" %02x", p[i]);
    if (n > 64)
        printf(" ...");
    printf("\n");
    fflush(stdout);
}

int main(int argc, char* argv[])
{
    const char* pszIp = (argc > 1) ? argv[1] : "127.0.0.1";
    const int nPort   = (argc > 2) ? atoi(argv[2]) : 7666;
    const int nSecs   = (argc > 3) ? atoi(argv[3]) : 5;
    int nSendLen      = (argc > 4) ? atoi(argv[4]) : 17;
    if (nSendLen < 1 || nSendLen > 17)
        nSendLen = 17;

    KRainbowLib cLib;
    if (!cLib.Load())
        return 1;

    KCoder2 cCoder;
    IClient* pClient = 0;
    if (!cLib.Manager()->CreateClient(204800u, &pClient, &cCoder) || !pClient)
    {
        puts("[probe] CreateClient failed");
        return 1;
    }

    pClient->RegisterEventHandler(0, ClientEventNotify);

    printf("[probe] connecting to %s:%d\n", pszIp, nPort);
    fflush(stdout);
    if (!pClient->ConnectTo(inet_addr(pszIp), (unsigned short)nPort))
    {
        puts("[probe] ConnectTo failed");
        return 1;
    }
    puts("[probe] ConnectTo returned true");

    // The 17-byte login: protocol 66 and a 16-byte GUID. The GUID is arbitrary
    // here -- no character is loaded, so the server's AttachPlayer will not
    // match it. What is being tested is that the packet arrives intact and is
    // recognised as protocol 66 with a legal length, i.e. that it gets past
    // CheckProtocolSize rather than tripping it.
    unsigned char abyLogin[17];
    abyLogin[0] = 66;
    for (int i = 1; i < 17; ++i)
        abyLogin[i] = (unsigned char)(0xA0 + i);

    bool bSent = false;
    const time_t tStart = time(0);

    while (time(0) - tStart < nSecs)
    {
        if (!bSent && g_nEventCount > 0)
        {
            Hexdump("send", abyLogin, (unsigned int)nSendLen);
            if (!pClient->SendPackToServer(abyLogin, (unsigned int)nSendLen))
                puts("[probe] SendPackToServer failed");
            bSent = true;
        }

        for (;;)
        {
            unsigned int nLen = 0;
            void* pData = pClient->GetPackFromServer(nLen);
            if (!pData || !nLen)
                break;
            Hexdump("recv", (const unsigned char*)pData, nLen);
        }

        usleep(20000);
    }

    if (!bSent)
    {
        // No event ever arrived. Send anyway so the log distinguishes "never
        // connected" from "connected but the server said nothing".
        puts("[probe] no connect event; sending regardless");
        Hexdump("send", abyLogin, (unsigned int)nSendLen);
        pClient->SendPackToServer(abyLogin, (unsigned int)nSendLen);
        sleep(2);
        unsigned int nLen = 0;
        void* pData = pClient->GetPackFromServer(nLen);
        if (pData && nLen)
            Hexdump("recv", (const unsigned char*)pData, nLen);
    }

    printf("[probe] done: %d events, last=%d\n", g_nEventCount, g_nLastEvent);
    pClient->Shutdown();
    pClient->Release();
    cLib.Unload();
    return 0;
}
