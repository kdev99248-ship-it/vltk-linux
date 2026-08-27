// The negative control for jx_layout.cpp. THIS FILE MUST NOT COMPILE.
//
// jx_layout.cpp holds 408 size assertions and 1429 offset assertions, and it
// builds clean. On its own that proves nothing: an empty file builds clean too,
// and so does one whose assertions are never instantiated. This file makes the
// same three claims with the numbers changed by one, so a clean build here
// would mean the checks over there are decoration.
//
// The three are not arbitrary. They are the layout hazards the generator was
// written to handle, and each would silently shift a packet if it were wrong:
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
//
// Run it deliberately; it is excluded from the default build:
//
//     cmake --build . --target negative_control     # expected: 3 errors
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
