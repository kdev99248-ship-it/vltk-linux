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
| Generate the protocol header | **done** — 574 packets, 93 types, 2 enums |
| Prove the generated layout matches the binary | **done, verified** — 2793 static_asserts, compiled |
| Prove the proof is not vacuous | **done, verified** — negative control fails as designed |
| Protocol ID table, client → server | **done, verified** — two independent sources, §3 |
| Protocol ID table, server → client | **done, partial coverage** — observed, not named, §4 |
| `KServerCore` + handshake | not started |

## 1. From a packet table to a compilable header

`protocol/binary_packets.tsv` was enough to *describe* the protocol and not
enough to *compile* it. Roughly thirty packets have a field whose type is
another struct — `KZhaoMuInfo`, `TRoleList`, `SViewItemInfo` — and a few of
those nest further. `dwarf_structs.py` gained `--types`, which walks the
transitive closure of everything a packet field refers to:

```
574 packets   2353 fields     protocol/binary_packets.tsv
 93 types      407 fields     protocol/binary_types.tsv
  2 enums       22 values     protocol/binary_enums.tsv
```

**The packet set is 574, not the 377 Phase 0 reported.** Two rules find them,
and both had to be widened once the ID work started asking which struct a given
protocol byte belongs to and kept turning up structs the table did not have.

*Transitive inheritance.* The original rule was "inherits from one of the known
protocol-header bases". That is one level deep, and the tree is deeper:
`AUCTION_ADDPRICE_C2S` inherits `AUCTION_PROTOCOLHEADER`, which inherits
`tagProtocolHeader`. Taking the closure instead of the immediate parent moved
377 → 569.

*The headerless five.* Five packets inherit nothing at all and carry the
protocol byte as a plain first member — `KILLER_QUERYKILLEE_RESULT0` and the
`TRYOUT` pair among them. The second rule is exactly that shape: first member
named `ProtocolType` or `cProtocol`, at offset 0, one byte wide. 569 → 574. It
is not a guess; the send-ID sweep in §4 caught the server filling in that member
on those types.

Three things in the closure needed deciding rather than transcribing.

**GCC's anonymous aggregates.** Eight types arrive named `._155`, `._157`,
`._164` and so on — a counter that restarts in every translation unit, so the
name is meaningless and ambiguous across the binary. They are renamed after
where they are used: `._157` becomes `tagFOUNDRY_CLIENTSEND_NecItemPos_t`. That
name is stable, unique, and says what the type is.

**Anonymous unions, declared.** Ten of the referenced types have no member
offsets at all, which is how DWARF records a union. They turn out to be C's
anonymous-union idiom, and one of them is `tagProtocolHeader` itself:

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

**Anonymous unions, flattened.** The harder case: GCC sometimes drops the union
DIE entirely and hangs its members off the enclosing struct, keeping every name
and *repeating the offset*. Nothing in the debug info says "union" — the overlap
is the whole of the evidence. `AUCTION_REPLYSCRIPTASK_R2G` has three `BYTE`s at
offset 6, `bState` / `bHasAutionNow` / `bSystemFull`, and emitted in sequence the
packet is 13 bytes on the wire instead of 11. `group_fields()` in
`gen_protocol.py` splits a field list into runs sharing an offset and emits a run
longer than one as a union. One struct binary-wide is affected, and it is a
packet the auction relay sends.

**Several names for one struct.** A struct can be reached under more than one
typedef, in CUs that never meet, and *each name can carry a different protocol
ID*: `tagNPC_REMOVE_SYNC` is also `NPC_REQUEST_FAIL`, `NPC_SIT_SYNC` and
`NPC_STATE_REQUEST_COMMAND`, and the code declares locals with all four. A table
that keeps one name per struct cannot be joined against the code that uses the
others, which is how nine send-ID rows initially looked like they referred to
packets that did not exist. `dwarf_structs.py` now records every typedef name in
the `alias` column and `gen_protocol.py` emits a `typedef` for each.

## 2. Why the generated layout can be trusted

`tools/gen_protocol.py` writes two files:

```
src/protocol/jx_protocol.h    666 types, 2756 fields
src/protocol/jx_layout.cpp    656 static_assert(sizeof), 2137 static_assert(offsetof)
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

2793 assertions that all pass could equally mean they are never evaluated. An
empty file also builds clean. `src/protocol/negative_control.cpp` makes five of
the same claims with the numbers changed by a known amount, and is excluded from
the default build because it is supposed to fail:

```
$ ./docker/gameserver-build/build.sh RelWithDebInfo negative_control
error: static assertion failed: EXPECTED FAILURE: the real offset is 65
  note: the comparison reduces to '(65 == 64)'      # tagItemSync.m_MaxDurability
error: static assertion failed: EXPECTED FAILURE: the real size is 140
  note: the comparison reduces to '(140 == 139)'    # VIEW_OTHER_DETAIL_INFO
error: static assertion failed: EXPECTED FAILURE: the real offset is 4
  note: the comparison reduces to '(4 == 2)'        # _tagSyncFileHead.pairFileName
error: static assertion failed: EXPECTED FAILURE: the real size is 718
  note: the comparison reduces to '(718 == 98)'     # BATTLE_NEW_ROUND_R2G
error: static assertion failed: EXPECTED FAILURE: the real size is 11
  note: the comparison reduces to '(11 == 13)'      # AUCTION_REPLYSCRIPTASK_R2G
```

The five are the layout hazards the generator was written for, and the compiler
reports the real value of each. The first is the one that could have gone wrong
quietly: `tagItemSync` inherits from *two* bases, and the 64-byte `SViewItemInfo`
has to land at offset 1, immediately behind the 1-byte protocol header. That only
happens if `pack(1)` reaches base classes and not just members. It does — the
compiler says 65.

Five packets use multiple inheritance: `KPROTO_SYNCRESIST`, `TongExProtocolGC`,
`TongExProtocolRG`, `tagItemSync`, `tagPLAYER_LEVEL_UP_SYNC`.

The last two entries are the two extraction bugs this phase found, kept as
controls now that they are fixed:

- **`BATTLE_NEW_ROUND_R2G`, 640 bytes short.** GCC hangs *every* `DW_TAG_subrange`
  off one `DW_TAG_array_type`, so `char[20][32]` is a single DIE with two
  subranges, not an array of arrays. Reading only the first subrange turned it
  into `char[32]`. `array_dims()` reads them all.
- **`AUCTION_REPLYSCRIPTASK_R2G`, 2 bytes long.** The flattened anonymous union
  in §1.

Both were caught by `--verify` and the compiler, not by a client desyncing at
run time, which is the point of doing it this way.

## 3. The IDs, client → server: two sources that agree

The header says what each packet *looks like*. It does not say which
`ProtocolType` byte selects it, and the client-facing IDs are `#define`s, which
leave no trace in DWARF. `--all-enums` finds 115 enums and 1098 enumerators in
the binary; the enums that survived did so because the code declares *variables*
of that type somewhere:

| Enum | Values | What it covers |
|---|---:|---|
| `c2s_PROTOCOL` | 164 | gateway/relay ↔ server, and the client protocols too |
| `TongExProtocol` | 127 | the guild extended protocol |
| `enumPartnerSubProtocolType` | 35 | partner subcommands |
| `LeagueProtocol` | 16 | league relay |
| `g2r_`/`r2g_` `CityWar`/`Battle` | 19 total | city war, battle relay |

`c2s_PROTOCOL` is the whole inbound table, and it survives. That is one source.
The second is the code that consumes it — and there is no switch to read.
`KProtocolProcess::ProcessNetMsg` is:

```c
byProtocol = *pMsg;
pfn = this->ProcessFunc[byProtocol].__pfn;
if (pfn) pfn(...); else printf("Unhandle Protocol %d\n", byProtocol);
```

The entire mapping lives in the array, and the array is filled once, in the
constructor: 2340 bytes of stores at `0x080F0760`.
`tools/ida/dump_dispatch.py` parses them out of the decompiler's output rather
than the disassembly on purpose — `this->ProcessFunc[70].__pfn` is Hex-Rays
having already worked out the array's offset in the object and the 8-byte stride
of an Itanium-ABI pointer-to-member, and redoing that from
`mov [ebx+0AAh], offset ...` would be our arithmetic to get wrong.

### The join

```
c2s_PROTOCOL          164 enumerators (157 distinct values, 7 boundary markers)
ProcessFunc[]          95 slots assigned: 84 handlers, 11 explicitly nulled
                        0 slots without an enumerator
of the 84 handlers     79 named identically to their enumerator
                        5 the same protocol, worded differently
```

Zero orphans is the result worth having: every slot the constructor touches has
a name in the enum, so the two artifacts describe the same table and neither has
a protocol the other has never heard of.

The five wording differences are not disagreements about the ID — both sources
agree on the byte — only about the word:

| ID | Handler | Enumerator |
|---:|---|---|
| 70 | `RemoveRole` | `c2s_removeplayer` |
| 94 | `PlayerDropItem` | `c2s_playerthrowawayitem` |
| 116 | `NpcReviveCommand` | `c2s_playerrevive` |
| 151 | `c2sSendDbData` | `c2s_getroledata_request` |
| 178 | `OnSetCanPublishFlagRequest` | `c2s_set_friend_publish_flag` |

Two smaller tables come out of the same constructor and are recorded alongside:
`m_NWClientProcess` (2 slots) and `m_NWRelayProcess` (13 slots), the nation-war
sub-dispatch.

### What "not in ProcessFunc[]" means

Of the 164 enumerators, 62 have no slot. That is not the same as unhandled.
`ProcessNetMsg` is the *last* stop, and a message only reaches it if
`KClientProcess::ProcessMessage` passed it on: everything below 64 is account and
gateway traffic settled long before, and the login-phase protocols are consumed
by `ProcessLoginProtocol`.

The 11 explicitly nulled slots are the interesting ones. The constructor memsets
the array and *then* writes 0 over eleven slots again, which is only worth doing
to say something. `c2s_ping` is the clearest: `KClientProcess` handles it
directly, and the null is what stops it reaching a second handler. A protocol
byte in neither set reaches the `Unhandle Protocol %d` printf and nothing else.

### The Windows header was right to distrust

`tools/cmp_protocol_ids.py` puts the two side by side:

```
c2s_PROTOCOL   header 100   binary 164
  agree              43
  DISAGREE           31
  header only        26
  binary only        90
```

Thirty-one conflicts, most of them a drift of one to seven in a contiguous run —
`c2s_playerthrowawayitem` is 95 in the header and 94 here, `c2s_ping` is 107 there
and 112 here. Those are two versions of the game, and using the header's numbers
would have produced a server that mostly worked and misrouted a third of the
client's messages. The Windows list was used for nothing. It is reported only as
a cross-check.

## 4. The IDs, server → client: observed, not named

There is no `s2c_PROTOCOL` to recover. The server only ever uses those constants
*as constants*, and a constant leaves nothing in DWARF — not in the relay, not in
libheaven, nowhere. The name does not exist in the shipped build.

But the server still has to *write* the ID into every packet it sends, and DWARF
does record the type of the local it writes into. So Hex-Rays gives us both
halves:

```c
tagEnterGame eg;        // <- the declared type, from DWARF
eg.cProtocol = 52;      // <- the constant, from the code
```

and that pair is the mapping, observed rather than assumed.
`tools/ida/dump_send_ids.py` decompiles the whole binary and collects every
assignment to `cProtocol`, `ProtocolType`, `ProtocolFamily` or `ProtocolID`
together with the declared type of what was assigned into:

```
# 8401 functions decompiled, 1 failed, 575 assignments found
```

Both header shapes are handled: `tagProtocolHeader` keeps the ID in a single byte
at offset 0, `EXTEND_HEADER` splits it into a family byte and an ID byte.
`gen_protocol_ids.py` turns the result into macros:

```
JX_ID(T)       201 packets   the byte in T's one-byte header
JX_FAMILY(T)    77 packets   ProtocolFamily, for the EXTEND_HEADER packets
JX_SUBID(T)     77 packets   ProtocolID, likewise
```

278 names, covering **275 of the 574 packet structs**. Each one carries the
function that wrote it as a comment, which is where to look to check it.

Three qualifications, all in the generated header:

- **Absent means unobserved, not unused.** A packet the server builds in code the
  decompiler could not read, or builds by memcpy over a buffer typed as `char*`,
  has no row. The 299 uncovered structs are a to-do list, not a contradiction.
- **Five structs are written with more than one value**, and that is normal here
  rather than a conflict to resolve: `PING_COMMAND` is 112, 130 or 153 depending
  on whether `KServerCore::PingClient`, `KServerCore::Loop` or
  `KClientProcess::ProcessPingReply` built it. No macro is emitted for those; the
  header lists them with their call sites.
- **The name is the typedef the call site used**, not necessarily the struct's own
  name — which is why §1's alias work had to come first.

`src/protocol/jx_protocol_ids.cpp` asserts all 355 of them: that the packet named
is a type this build actually declares, and that the ID fits in the byte it is
written into. It compiles as part of `jx_protocol`.

## 5. Regenerating

The generated files are committed rather than produced during the build. The
build runs in a container with the source tree mounted read-only, and a header
that defines the wire format should be reviewable in a diff.

```bash
python3 tools/dwarf_structs.py ../server1/jx_linux_y \
    --packets protocol/binary_packets.tsv \
    --types   protocol/binary_types.tsv \
    --enums   protocol/binary_enums.tsv \
    --verify
python3 tools/gen_protocol.py     protocol/ -o src/protocol/
python3 tools/gen_protocol_ids.py protocol/ -o src/protocol/
```

The two `tools/ida/` scripts are not part of that loop — they need IDA and a few
minutes, and their output (`protocol/dispatch_c2s.tsv`, `protocol/send_ids.tsv`)
is committed as data.

`--verify` is the check that the extraction is internally consistent before any
of it reaches a header:

```
verify: 574 packet layouts
  last field ends exactly at sizeof   560
  flexible tail starting at sizeof     13
  trailing alignment padding            1
  INCONSISTENT                          0

verify: 93 referenced type layouts  (10 unions / empty, not applicable)
  last field ends exactly at sizeof    81
  flexible tail starting at sizeof      1
  trailing alignment padding            1
  INCONSISTENT                          0
```

## Exit criteria

- [x] The protocol layer compiles on Linux, `-m32`
- [x] Its layouts are byte-identical to the shipped binary, checked by the compiler
- [x] That check is shown to be non-vacuous
- [x] Protocol IDs recovered and cross-checked against the dispatch table
- [ ] `KServerCore` starts and accepts a connection
- [ ] The handshake completes against the oracle

The handshake specifics are already reverse-engineered and recorded in the
s3relay work: a 42-byte `ACCOUNT_BEGIN` with obfuscated keys at offsets
0x08/0x11, then the chained KSG cipher. That is the Linux protocol. The Windows
source describes a 32-byte constant-XOR handshake instead, and using it
crash-loops the gateway.
