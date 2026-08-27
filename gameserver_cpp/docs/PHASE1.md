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
| The KSG cipher and its key table | **done, verified** — 96 vectors, two implementations, §6 |
| `main` → `KSOServer` → `KServerCore` → login | **done, runs** — §7 |
| The handshake, end to end | **done, verified** — against the shipped engine, §8 |
| The five outbound server links | Phase 2 — §9, planned in [PHASE2.md](PHASE2.md) |

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

## 6. The cipher, and a bug it found in the oracle

The server owns no socket code. `libheaven.so` listens, accepts and buffers;
`librainbow.so` is the same engine's client side, used for the outbound links.
Neither knows the cipher — the server registers one with
`IServer::RegisterCoder` and heaven calls it on every packet in both directions.
So `KCoder2` is the entire cryptographic surface of the port, and it is 33 bytes
of code wrapping `KSG_DecodeEncode2`.

Two details in it are easy to get wrong and impossible to notice:

- **The block index counts down** while the buffer walks forward. Block 0 of the
  buffer is keyed with `nBlocks - 1`, the last block with 0. In the binary the
  loop is `sub ebx, 1` / `cmp ebx, 0FFFFFFFFh`.
- **The key is chained**: each block's key is
  `g_uPublicKeys[(i + prevKey) % 5679] + 0x2E6D23C1`, so a single wrong block
  corrupts everything after it.

The table is the 22716 bytes at `g_uPublicKeys` (`0x082AB6A0`), read out of the
binary and committed as generated C++ rather than loaded from a file — because
the shipped server holds it in `.rodata`, and a build that read it from disk
would already differ. `sha256 5491f086…`, byte-identical to
`config/reference/heaven_table.bin`.

### Checking it

A wrong cipher and a dead connection look exactly alike from outside, so the
implementation is diffed against an independent one:
`ksg_decode()` in `tools/oracle_proxy.py`, transcribed from the s3relay server
and verified byte-exact against live `bishop_y` traffic before this port
existed. `ksg_vectors` prints 96 vectors — every tail length, the 5-byte ping,
the 9-byte ping reply, the 17-byte login, up to 1024 bytes, across six keys —
and `check_ksg.py` recomputes each one:

```
$ ./build/docker/ksg_vectors > vectors.txt
$ python3 tools/check_ksg.py vectors.txt
table   ../config/reference/heaven_table.bin (5679 keys)
vectors 96
ok      every vector agrees with tools/oracle_proxy.py
```

`ksg_vectors` also re-runs the cipher over its own output and checks the
plaintext comes back, since the whole thing is only correct if it is symmetric.

**The first run disagreed on 8 of 96, and the C++ was right.** Every mismatch
had key `0xFFFFFFFF` and a buffer of two blocks or more. The original is

```asm
lea eax, [ebx+esi]        ; counter + key -- 32-bit, wraps
xor edx, edx
div uNumOfPubKeys
```

so the addition wraps at 2³² *before* the modulo. Python integers do not wrap,
and the transcription had lost the mask. With realistic keys it is unobservable
— a 17-byte packet needs the key within 3 of 2³², about one connection in a
billion — which is exactly why capture-diffing against live traffic never showed
it. It is fixed in `oracle_proxy.py` with the reason written next to it.

Worth stating plainly, because the oracle is the thing that decides whether the
port is correct: this was a bug **in the oracle**, found by the port.

## 7. The process half: `main` → `KSOServer`

`KSOServer` is config, sockets and the clock; it knows nothing about the game.
The order in `Initialize` is preserved from `0x0804C0A0` because it is
observable: libraries before config, so a missing `libheaven.so` is reported
before a missing `servercfg.ini`.

The clock is the part worth reading twice. Two counters run at different rates:

```
m_dwElapseTime   milliseconds since startup
m_dwElapseTick   144ths of a second since startup
m_dwGameTick     advances by 8 per game loop
```

144/8 = **18 game loops per second**, and `m_nGameFPS` is the loop count measured
back against real time. `Loop()` sleeps 1 ms whenever it is ahead of schedule,
which is what keeps a single-threaded server off a spin loop: heaven does the
socket work on its own thread and leaves decoded packets in per-client queues,
so the main loop only ever drains queues and ticks.

Two behaviours are reproduced rather than tidied, and both are deliberate:

- **The FPS warning fires on 17 loops out of every 18.** The test is
  `m_nGameFPS <= 17 && m_dwGameLoop % 18 != 0`, which reads like an inverted
  rate-limit. A struggling server prints it almost every tick. That is what the
  deployed logs look like and what they are read against.
- **`OpenService` binds the *internet* address, not the intranet one.** On a host
  where the two differ this is the address clients must reach, and a wrong
  `[FixIp] InternetIp` makes the listen fail outright rather than bind the wrong
  interface. This is the bug that produced `Failed to open service on port[6666]`
  in the deploy tooling.

`GetLocalIpAddress` takes `eth0` as the internet side and `eth1` as the intranet
side, then swaps them if `eth0` starts `192.168` — on the reasoning that a
private address cannot be the public one. With no interfaces at all both come
back 0 and `[FixIp]` has to supply them, which is how the container run below
works.

## 8. The handshake

It is **17 bytes: protocol 66 and a 16-byte GUID** — `tagLogicLogin`. That is
the entire inbound login: no account name, no password, no key exchange. Those
happened at the gateway, which loaded the character into this server's player set
and handed the client a GUID; this message is the client saying which of the
already-loaded characters it is.

Stated plainly because the obvious guess is wrong: this is **not** the 42-byte
`ACCOUNT_BEGIN` handshake with obfuscated keys at `0x08`/`0x11`. That one is real
and correct, and it belongs to the relay/paysys link, not here. What the two
share is the KSG cipher and its table, nothing else.

### Testing it against the shipped engine

`login_probe` speaks to the ported server through `librainbow.so` — the shipped
client engine — so the framing, buffering and key handling are the real ones and
the only piece from this tree on the client side is `KCoder2`. Both processes run
in one container on `--network none`, so nothing touches the host or the deployed
stack:

```
docker run -d --name jxtest --network none -t -v .../run:/work -w /work \
    jx-gameserver-build ./jx_gameserver 7666
docker exec jxtest ./login_probe 127.0.0.1 7666 4 17    # valid
docker exec jxtest ./login_probe 127.0.0.1 7666 4 16    # one byte short
```

The server's console:

```
Intranet ip: 127.0.0.1
Internet ip: 127.0.0.1
[Gateway]IP:127.0.0.1, Port:5632
[Database]IP:127.0.0.1, Port:5001
[Transfer]IP:127.0.0.1, Port:5003
[Tong]IP:127.0.0.1, Port:5005
[Chat]IP:127.0.0.1, Port:5004
[phase1] outbound server links are not opened by this build.
----------[Warning...] GameServer' FPS=0----------
[error]NetServer:Invalid Protocol Size! protocol(66) expect(17) actual(16)
[ShutdownClient]	shut down client(1) - ip(127.0.0.1 : 49398) because invalid protocol!
```

and `gameserver.log`, CRLF as in the original:

```
[2026-08-27 08:40:10]Gameserver startup
```

**The negative case is the one that proves something.** The valid 17-byte login
is accepted in silence — connect, send, no reply, no disconnect — and silence is
weak evidence, because a server that decoded nothing at all would also be silent.
One byte short produces `protocol(66) expect(17) actual(16)` and a disconnect,
and those three numbers can only appear together if

- heaven decoded the packet with our `KCoder2` and the first byte arrived as 66,
- the recovered size table says protocol 66 is 17 bytes,
- `CheckProtocolSize` ran and the shutdown path found the client's address.

The valid case is then meaningful in the other direction: it got past the same
gate and reached `ProcessLoginProtocol`, which returned 0 because `AttachPlayer`
has no loaded characters to match the GUID against — and that is also what the
shipped server does with an empty player set. Accepting the connection, accepting
the packet, finding nothing and staying silent is a real match rather than an
accident of both sides being broken.

**What has not been done: a byte diff against the shipped binary.** It is not
skipped for convenience — `jx_linux_y` will not start without its five outbound
links, so standing up an oracle instance means standing up gateway, database,
transfer, chat and tong, which is Phase 2 in its entirety. The engine-level test
above is the strongest check available before that exists.

## 9. What is deliberately missing

Every omission carries a `// Phase 2` comment at the point where the shipped code
does something, rather than being silently absent. The significant ones:

| Where | What the shipped server does |
|---|---|
| `CreateClientConnections` | opens five `CClientConnection`s and **fails Initialize if any refuses** |
| `KServerCore::Initialize` | product config, the log sinks, the timer list, `g_InitCore`, `OnLaunch` |
| `KSOServer::Initialize` | `g_SetRootPath` / `g_InitEngine("package.ini")` — the package VFS |
| `AttachPlayer` | walks `KPlayerSet` for a loaded character with a matching GUID |
| `SendGameDataToClient` | seven steps of `PlayerDbLoading`, then state 2 and a one-byte 67 |
| `ProcessSyncReplyProtocol` | `AddPlayerToWorld`, then returns 1 |
| `OnClientClose` | the leave-the-world path: notify gateway and database, drop the role |
| state 3 | `KPlayerSet::ProcessClientMessage` — the game |

Two of those are behavioural differences a reader should know about rather than
discover:

- **This build starts without a gateway; the shipped one does not.** Temporary,
  and the reason Phase 1 could be tested at all.
- **`ProcessSyncReplyProtocol` returns 0 where the shipped one returns 1.**
  Returning 1 would move the session to "in the world" with no world in it, so
  the honest answer until `AddPlayerToWorld` exists is that the sync did not
  complete.

`KIniFile` is a reimplementation, not a port: the shipped one reads through the
package VFS, and `servercfg.ini` is the one file loaded by plain relative path.
Its surface is exactly the three methods the startup path calls, with the
signatures the manglings give.

## Exit criteria

- [x] The protocol layer compiles on Linux, `-m32`
- [x] Its layouts are byte-identical to the shipped binary, checked by the compiler
- [x] That check is shown to be non-vacuous
- [x] Protocol IDs recovered and cross-checked against the dispatch table
- [x] The KSG cipher agrees with an independent implementation on 96 vectors
- [x] `KServerCore` starts and accepts a connection
- [x] The handshake completes against the shipped network engine, positive and
      negative case
- [ ] A byte diff against a running `jx_linux_y` — blocked on the five outbound
      links, i.e. on Phase 2
