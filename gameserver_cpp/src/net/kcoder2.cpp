#include "kcoder2.h"

#include "ksg.h"

// Out of line, so the vtable is emitted here and in exactly one place. heaven
// calls through it from its own thread.
void KCoder2::Encode(void* pData, unsigned int nLen, unsigned int nKey)
{
    KSG_DecodeEncode2(nLen, (unsigned char*)pData, &nKey);
}

void KCoder2::Decode(void* pData, unsigned int nLen, unsigned int nKey)
{
    KSG_DecodeEncode2(nLen, (unsigned char*)pData, &nKey);
}
