#include "ksg.h"

// Transcribed from KSG_DecodeEncode2 @ 0x0804D700.
//
// Two details are easy to get wrong and both change the keystream:
//
//   1. The block index counts DOWN, from (uSize/4 - 1) to 0. It is not the
//      position in the buffer -- the buffer walks forward while the index walks
//      backward -- so a "cleaned up" ascending loop produces a different
//      sequence for every packet longer than four bytes.
//
//   2. The key CHAINS. Each iteration's table index is (i + key) where key is
//      the value derived in the previous iteration, not the key the caller
//      passed. Only the first block uses the caller's key.
//
// The trailing 1-3 bytes are handled separately, XORed against one more table
// entry selected by the remainder itself and consumed a byte at a time from the
// low end.
BOOL KSG_DecodeEncode2(unsigned int uSize, unsigned char* pbyBuf, unsigned int* puKey)
{
    const unsigned int nBlocks = uSize >> 2;
    const unsigned int nTail   = uSize & 3;

    unsigned int uKey = *puKey;

    if (nBlocks)
    {
        unsigned char* p = pbyBuf;
        unsigned int i = nBlocks - 1;
        for (;;)
        {
            // Wraps at 2^32 exactly as the original does; the modulus then
            // brings it back into the table.
            const unsigned int nIndex = (i + uKey) % g_uNumOfPubKeys;
            uKey = g_uPublicKeys[nIndex] + 0x2E6D23C1u;

            unsigned int uBlock;
            __builtin_memcpy(&uBlock, p, 4);
            uBlock ^= uKey;
            __builtin_memcpy(p, &uBlock, 4);
            p += 4;

            if (i == 0)
                break;
            --i;
        }
    }

    if (nTail)
    {
        unsigned char* p = pbyBuf + 4 * nBlocks;
        unsigned int uMask = uKey ^ g_uPublicKeys[nTail % g_uNumOfPubKeys];
        for (unsigned int j = 0; j < nTail; ++j)
        {
            p[j] ^= (unsigned char)uMask;
            uMask >>= 8;
        }
    }

    // Derived from the key the caller passed in, not from the chained value.
    *puKey = 31 * *puKey + 0x08088405u;
    return 1;
}

// The outbound-link spelling. See the note in ksg.h: @0x0804D650 is a second,
// instruction-identical copy of the function above, so forwarding is not a
// simplification -- it is what the two copies compute.
BOOL KSG_DecodeEncode(unsigned int uSize, unsigned char* pbyBuf, unsigned int* puKey)
{
    return KSG_DecodeEncode2(uSize, pbyBuf, puKey);
}

// @0x0804D7B0 and @0x0804D7E0. The local copy is load-bearing: without it the
// caller's key would be advanced by the write-back at the end of the cipher,
// and the links -- unlike heaven's per-packet keys -- reuse theirs.
BOOL KSG_DecodeBuf(unsigned int uSize, unsigned char* pbyBuf, unsigned int* puKey)
{
    unsigned int uKey = *puKey;
    return KSG_DecodeEncode(uSize, pbyBuf, &uKey);
}

BOOL KSG_EncodeBuf(unsigned int uSize, unsigned char* pbyBuf, unsigned int* puKey)
{
    unsigned int uKey = *puKey;
    return KSG_DecodeEncode(uSize, pbyBuf, &uKey);
}
