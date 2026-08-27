// The KSG wire cipher.
//
// Every packet in both directions passes through this, called by libheaven.so
// through the ICoder the server registers. It is a table-driven stream XOR:
// the table is 5679 DWORDs of fixed data, and the key selects a starting point
// in it and then chains -- each block's key is derived from the previous
// block's table entry, so a single wrong byte desynchronises everything after
// it in the same packet.
//
// Two constants and the table are the whole secret:
//
//     g_uPublicKeys    @ 0x082AB6A0 in jx_linux_y, 22716 bytes
//     g_uNumOfPubKeys  @ 0x082B0F5C = 5679
//     0x2E6D23C1       added to every table entry before it becomes a key
//     0x08088405       the key advance, which this server never uses -- see
//                      KCoder2 in kcoder2.h
//
// The table is byte-identical to config/reference/heaven_table.bin, which was
// recovered independently when the relay was made to talk to paysys. Two
// independent recoveries agreeing is why it is trusted.
#ifndef JX_NET_KSG_H
#define JX_NET_KSG_H

#include "windows.h"

// Both defined in ksg_table.cpp, which is generated:
//     python3 tools/gen_ksg_table.py ../config/reference/heaven_table.bin
//         -o src/net/ksg_table.cpp
extern const unsigned int g_uPublicKeys[];
extern const unsigned int g_uNumOfPubKeys;

// In-place, symmetric: encoding and decoding are the same operation, which is
// why KCoder2::Encode and KCoder2::Decode in the shipped binary are two
// identical 33-byte functions.
//
// puKey is in/out in the original signature and the write-back is real -- but
// no caller in the server ever reads it back, so the cipher behaves as if it
// were stateless. Kept as a pointer anyway: this is the shape the function has,
// and a later caller (the relay does chain) will need it.
BOOL KSG_DecodeEncode2(unsigned int uSize, unsigned char* pbyBuf, unsigned int* puKey);

#endif  // JX_NET_KSG_H
