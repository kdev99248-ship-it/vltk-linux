// The negative control for jx_layout.cpp. THIS FILE MUST NOT COMPILE.
//
// jx_layout.cpp holds 656 size assertions and 2137 offset assertions, and it
// builds clean. On its own that proves nothing: an empty file builds clean too,
// and so does one whose assertions are never instantiated. This file makes five
// claims that are wrong by a known amount, so a clean build here would mean the
// checks over there are decoration.
//
// The five are not arbitrary. They are the layout hazards the generator was
// written to handle, and each would silently shift a packet if it were wrong.
// The first three were found in phase 0, the last two by the phase 1 sweep that
// went looking for which struct each protocol ID belongs to:
//
//   tagItemSync         multiple inheritance -- SViewItemInfo is 64 bytes and
//                       must land at offset 1, right behind the 1-byte protocol
//                       header, which only happens if pack(1) reaches base
//                       classes and not just members.
//   VIEW_OTHER_DETAIL_INFO
//                       trailing padding -- its members stop at 139 but the
//                       binary says 140, because on i386 a `long long` member
//                       gives the struct 4-byte alignment.
//   _tagSyncFileHead    internal padding -- two bytes the binary shows between
//                       the header base and the first member.
//   BATTLE_NEW_ROUND_R2G
//                       a multi-dimensional array. GCC hangs every extent off
//                       one array DIE, so reading only the first subrange turns
//                       char[20][32] into char[32] and loses 640 bytes.
//   AUCTION_REPLYSCRIPTASK_R2G
//                       an anonymous union GCC flattened into its parent. Three
//                       BYTEs share offset 6; emitted in sequence the packet is
//                       13 bytes on the wire instead of 11.
//
// Run it deliberately; it is excluded from the default build:
//
//     cmake --build . --target negative_control     # expected: 5 errors
//
#include <cstddef>

#include "jx_protocol.h"

#pragma GCC diagnostic ignored "-Winvalid-offsetof"

static_assert(offsetof(tagItemSync, m_MaxDurability) == 64,
              "EXPECTED FAILURE: the real offset is 65");
static_assert(sizeof(VIEW_OTHER_DETAIL_INFO) == 139,
              "EXPECTED FAILURE: the real size is 140");
static_assert(offsetof(_tagSyncFileHead, pairFileName) == 2,
              "EXPECTED FAILURE: the real offset is 4");
static_assert(sizeof(BATTLE_NEW_ROUND_R2G) == 98,
              "EXPECTED FAILURE: the real size is 718");
static_assert(sizeof(AUCTION_REPLYSCRIPTASK_R2G) == 13,
              "EXPECTED FAILURE: the real size is 11");
