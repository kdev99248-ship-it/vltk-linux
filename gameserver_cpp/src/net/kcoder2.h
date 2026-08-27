// The ICoder the game server hands to libheaven.so.
//
// KCoder2::Encode and KCoder2::Decode are, in the shipped binary, two identical
// 33-byte functions -- the cipher is symmetric, so there is nothing to
// distinguish them:
//
//     void KCoder2::Encode(void *pData, unsigned nLen, unsigned nKey)
//     { KSG_DecodeEncode2(nLen, pData, &nKey); }
//
// nKey arriving BY VALUE is the interesting part. KSG_DecodeEncode2 advances
// the key through *puKey on the way out, but here that write lands in a
// parameter slot that is discarded when the function returns. So the advance
// never happens as far as this server is concerned: every packet is coded with
// the key heaven supplies for it and no state carries between calls.
//
// That is not a bug being reproduced for its own sake -- it is what makes the
// server's half of the cipher stateless, and any "fix" here would desynchronise
// it from every client.
#ifndef JX_NET_KCODER2_H
#define JX_NET_KCODER2_H

#include "heaven_abi.h"

class KCoder2 : public ICoder
{
public:
    void Encode(void* pData, unsigned int nLen, unsigned int nKey);
    void Decode(void* pData, unsigned int nLen, unsigned int nKey);
};

#endif  // JX_NET_KCODER2_H
