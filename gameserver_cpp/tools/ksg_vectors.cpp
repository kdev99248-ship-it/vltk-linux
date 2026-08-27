// Prints KSG test vectors for tools/check_ksg.py to verify.
//
// The cipher is the one part of the port that cannot be checked by reading the
// output: get it wrong and every packet is garbage, but a wrong cipher looks
// exactly like a closed connection. So it is checked against an independent
// implementation instead -- ksg_decode() in tools/oracle_proxy.py, which was
// verified byte-exact against live bishop_y traffic before this port existed.
//
// This half runs in the build container (where the C++ is), prints its answers,
// and check_ksg.py recomputes them on the host (where heaven_table.bin is):
//
//     cmake --build build --target ksg_vectors
//     ./build/ksg_vectors > vectors.txt
//     python3 tools/check_ksg.py vectors.txt
//
// Sizes are chosen for the edges: 0, every tail length 1..3, the 5-byte ping,
// the 9-byte ping reply, the 17-byte login, and enough long ones that the
// key chain runs for a while.
#include <stdio.h>

#include "ksg.h"

static const unsigned int kSizes[] = {
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 17, 33, 100, 255, 256, 1024
};

static const unsigned int kKeys[] = {
    0u, 1u, 2u, 0x12345678u, 0x2E6D23C1u, 0xFFFFFFFFu
};

int main(void)
{
    // A plain LCG rather than rand(), so the same vectors come out of any libc.
    unsigned int uState = 0x1BADB002u;

    for (unsigned int k = 0; k < sizeof(kKeys) / sizeof(kKeys[0]); ++k)
    {
        for (unsigned int s = 0; s < sizeof(kSizes) / sizeof(kSizes[0]); ++s)
        {
            const unsigned int nSize = kSizes[s];

            unsigned char abyPlain[1024];
            unsigned char abyBuf[1024];
            for (unsigned int i = 0; i < nSize; ++i)
            {
                uState = 1103515245u * uState + 12345u;
                abyPlain[i] = (unsigned char)(uState >> 16);
                abyBuf[i] = abyPlain[i];
            }

            unsigned int uKey = kKeys[k];
            KSG_DecodeEncode2(nSize, abyBuf, &uKey);

            // "-" for an empty buffer, so every line has four fields.
            printf("%u %08x ", nSize, kKeys[k]);
            if (!nSize)
                printf("- -");
            else
            {
                for (unsigned int i = 0; i < nSize; ++i)
                    printf("%02x", abyPlain[i]);
                printf(" ");
                for (unsigned int i = 0; i < nSize; ++i)
                    printf("%02x", abyBuf[i]);
            }
            printf("\n");

            // Symmetry: running it again on the ciphertext with the same key
            // must give the plaintext back. If this ever fails the cipher is
            // wrong in a way no capture diff would localise.
            unsigned int uKey2 = kKeys[k];
            KSG_DecodeEncode2(nSize, abyBuf, &uKey2);
            for (unsigned int i = 0; i < nSize; ++i)
            {
                if (abyBuf[i] != abyPlain[i])
                {
                    fprintf(stderr, "not symmetric at size=%u key=%08x byte=%u\n",
                            nSize, kKeys[k], i);
                    return 1;
                }
            }
        }
    }
    return 0;
}
