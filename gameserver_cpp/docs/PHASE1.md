# Phase 1 — The protocol layer

Phase 0 ended on a result that redirected this phase. The Windows protocol
headers are wrong for 44% of the structs both trees define and missing 236 of
the packets this server sends, so there is nothing worth porting in them. The
shipped binary describes its own types, so the protocol layer is **generated**
from that description instead.

## Status

| Workstream | State |
|---|---|
| Extract the type closure, not just packets | **done** — `--types`, `--enums` on `dwarf_structs.py` |
| Generate the protocol header | **done** — 412 types, 1827 fields |
| Prove the generated layout matches the binary | **done, verified** — 1837 static_asserts, compiled |
| Prove the proof is not vacuous | **done, verified** — negative control fails as designed |
| Protocol ID table | **blocked on RE** — see §3 |
| `KServerCore` + handshake | not started |

## 1. From a packet table to a compilable header

`protocol/binary_packets.tsv` was enough to *describe* the protocol and not
enough to *compile* it. Roughly thirty packets have a field whose type is
another struct — `KZhaoMuInfo`, `TRoleList`, `SViewItemInfo` — and a few of
those nest further. `dwarf_structs.py` gained `--types`, which walks the
transitive closure of everything a packet field refers to:

```
377 packets   1678 fields     protocol/binary_packets.tsv
 36 types      153 fields     protocol/binary_types.tsv
  2 enums       22 values     protocol/binary_enums.tsv
```

Two things in the closure needed deciding rather than transcribing.

**GCC's anonymous aggregates.** Eight types arrive named `._155`, `._157`,
`._164` and so on — a counter that restarts in every translation unit, so the
name is meaningless and ambiguous across the binary. They are renamed after
where they are used: `._157` becomes `tagFOUNDRY_CLIENTSEND_NecItemPos_t`. That
name is stable, unique, and says what the type is.

**Anonymous unions.** Four of the eight have no member offsets at all, which is
how DWARF records a union. They turn out to be C's anonymous-union idiom, and
one of them is `tagProtocolHeader` itself:

```cpp
struct tagProtocolHeader {
    union {
        BYTE cProtocol;
        BYTE ProtocolType;
    };
};
```

Two spellings for the byte at offset 0. The generator inlines these at their use
site rather than declaring them as named types, because that is what they are.

## 2. Why the generated layout can be trusted

`tools/gen_protocol.py` writes two files:

```
src/protocol/jx_protocol.h    412 types, 1827 fields
src/protocol/jx_layout.cpp    408 static_assert(sizeof), 1429 static_assert(offsetof)
```

The split is deliberate. Assertions in the header would be re-checked by every
translation unit that includes it; in their own file they are checked once, and
that file failing to compile is exactly the signal wanted.

**Everything is `#pragma pack(1)` with the padding written out explicitly.** The
alternative — declare the fields and let the compiler align them — assumes this
compiler agrees with the one that built the server in 2009. It does not have to.
Two structs prove the point:

| Struct | What the binary shows |
|---|---|
| `VIEW_OTHER_DETAIL_INFO` | members end at 139, `sizeof` is **140** |
| `_tagSyncFileHead` | 2 unused bytes between the header base and the first member |

Neither is `pack(1)` upstream. `VIEW_OTHER_DETAIL_INFO` has `long long` members,
which on i386 give a struct 4-byte alignment, so 139 rounds up to 140. A
generator that assumed `pack(1)` everywhere would emit 139 and shift every field
after it in the containing packet.

The header also asserts the size of every primitive it uses — `BYTE`, `DWORD`,
`INT64`, `time_t`, `size_t`, `LPVOID`. A 64-bit build, or a 32-bit one with
`_TIME_BITS=64`, does not merely change a struct size; it desynchronises the
client. Better to fail at the `#include`.

**It compiles clean, `-m32`, zero warnings:**

```
[ 75%] Building CXX object CMakeFiles/jx_protocol.dir/src/protocol/jx_layout.cpp.o
[100%] Linking CXX static library libjx_protocol.a
```

### The negative control

1837 assertions that all pass could equally mean they are never evaluated. An
empty file also builds clean. `src/protocol/negative_control.cpp` makes the same
three claims with the numbers changed by one, and is excluded from the default
build because it is supposed to fail:

```
$ ./docker/gameserver-build/build.sh RelWithDebInfo negative_control
error: static assertion failed: EXPECTED FAILURE: the real offset is 65
  note: the comparison reduces to '(65 == 64)'      # tagItemSync.m_MaxDurability
error: static assertion failed: EXPECTED FAILURE: the real size is 140
  note: the comparison reduces to '(140 == 139)'    # VIEW_OTHER_DETAIL_INFO
error: static assertion failed: EXPECTED FAILURE: the real offset is 4
  note: the comparison reduces to '(4 == 2)'        # _tagSyncFileHead.pairFileName
```

The three are the layout hazards the generator was written for, and the compiler
reports the real value of each. The first is the one that could have gone wrong
quietly: `tagItemSync` inherits from *two* bases, and the 64-byte `SViewItemInfo`
has to land at offset 1, immediately behind the 1-byte protocol header. That only
happens if `pack(1)` reaches base classes and not just members. It does — the
compiler says 65.

Five packets use multiple inheritance: `KPROTO_SYNCRESIST`, `TongExProtocolGC`,
`TongExProtocolRG`, `tagItemSync`, `tagPLAYER_LEVEL_UP_SYNC`.

## 3. What DWARF does not give: the protocol IDs

The header says what each packet *looks like*. It does not say which
`ProtocolType` byte selects it, and that mapping is **not in the debug info**.
`--all-enums` finds 115 enums and 1098 enumerators in the binary, and the main
client protocol is not among them:

| Enum | Values | What it covers |
|---|---:|---|
| `c2s_PROTOCOL` | 164 | gateway/relay ↔ server |
| `TongExProtocol` | 127 | the guild extended protocol |
| `enumPartnerSubProtocolType` | 35 | partner subcommands |
| `LeagueProtocol` | 16 | league relay |
| `g2r_`/`r2g_` `CityWar`/`Battle` | 19 total | city war, battle relay |

The client-facing IDs are `#define`s, and macros leave no trace in DWARF. So the
ID table has to come from somewhere else: the Windows `KProtocolDef.h` supplies
candidate *names*, and the dispatch switch in the binary supplies the *values*
that this build actually accepts. Those have to be cross-checked against each
other — the Phase 0 lesson applies unchanged, and the Windows list cannot be
trusted on its own.

That is the next piece of work, and it is reverse engineering rather than
extraction.

## 4. Regenerating

The generated files are committed rather than produced during the build. The
build runs in a container with the source tree mounted read-only, and a header
that defines the wire format should be reviewable in a diff.

```bash
python3 tools/dwarf_structs.py ../server1/jx_linux_y \
    --packets protocol/binary_packets.tsv \
    --types   protocol/binary_types.tsv \
    --enums   protocol/binary_enums.tsv \
    --verify
python3 tools/gen_protocol.py protocol/ -o src/protocol/
```

`--verify` is the check that the extraction is internally consistent before any
of it reaches a header:

```
verify: 377 packet layouts
  last field ends exactly at sizeof   367
  flexible tail starting at sizeof     10
  trailing alignment padding            0
  INCONSISTENT                          0

verify: 36 referenced type layouts  (4 unions / empty, not applicable)
  last field ends exactly at sizeof    31
  trailing alignment padding            1
  INCONSISTENT                          0
```

## Exit criteria

- [x] The protocol layer compiles on Linux, `-m32`
- [x] Its layouts are byte-identical to the shipped binary, checked by the compiler
- [x] That check is shown to be non-vacuous
- [ ] Protocol IDs recovered and cross-checked against the dispatch switch
- [ ] `KServerCore` starts and accepts a connection
- [ ] The handshake completes against the oracle

The handshake specifics are already reverse-engineered and recorded in the
s3relay work: a 42-byte `ACCOUNT_BEGIN` with obfuscated keys at offsets
0x08/0x11, then the chained KSG cipher. That is the Linux protocol. The Windows
source describes a 32-byte constant-XOR handshake instead, and using it
crash-loops the gateway.
