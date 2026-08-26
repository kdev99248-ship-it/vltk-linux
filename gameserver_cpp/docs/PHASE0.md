# Phase 0 — Measure and instrument

Phase 0 does not port anything. It answers three questions that everything after
depends on, and builds the harness that will say whether the port is correct.

1. **How much work is there, and where?** — the worklist
2. **Do the protocol headers even compile on Linux, and are the layouts right?** — the struct probe
3. **How will we know the port behaves like the original?** — the oracle

## Status

| Workstream | State |
|---|---|
| Symbol export + worklist | **done, verified** — tooling run, output checked |
| Lua binding inventory | **done, verified** |
| Struct probe | **done, verified** — compiles and runs; all 390 sizes in `protocol/struct_sizes.tsv` |
| Oracle proxy + differ | **done, verified** — 15/15 self-test checks pass, incl. the real KSG table |
| Win32 compat layer | **compiles** — `-m32`, zero errors |
| CMake + Docker toolchain | **verified end to end** — produces an ELF32 i386 binary |
| Layouts confirmed against the binary | **done** — and the answer was *no*; see §5 |

The dev host has Python 3.11 and no C++ toolchain, so the build runs on the
project VPS in a container. That path now works: `build.sh` configures, compiles
and links, and the output is

```
ELF 32-bit LSB pie executable, Intel i386, dynamically linked, with debug_info
```

which is the architecture the shipped `jx_linux_y` uses.

**Phase 0 is closed, and it closed on a result that changes the plan.** The
shipped binary turned out to carry full debug info, so the protocol layouts could
be read out of it exactly rather than inferred. They do not match the Windows
headers: of the 158 structs both sides define, 69 differ. §5 has the numbers and
what follows from them.

## 1. The worklist

`tools/build_worklist.py` reads the 8402 functions exported from IDA
(`tools/symbols/ida_funcs.tsv`) and asks, for each `Class::Method`, whether a
definition exists anywhere in the Windows source tree.

```
total 4040 methods  1184.9 KB
PORT  1149 methods   373.9 KB  (32%)
RE    2891 methods   811.1 KB  (68%)
```

**Method level, not class level.** Matching on class names gives ~72% coverage
and is wrong. `KItemList` matches, but the hit is `friend class KItemList;` — a
forward declaration with nothing behind it. Only a `Class::Method` definition
means the code exists.

Heaviest classes (KB of compiled code):

| Class | Total | RE | Port |
|---|---:|---:|---:|
| KPlayer | 101.4 | 29.8 | 71.6 |
| KNpc | 74.4 | 25.6 | 48.8 |
| KItemList | 48.3 | 32.5 | 15.8 |
| **KTongLogic** | **43.6** | **43.6** | **0.0** |
| KNpcAI | 36.6 | 27.1 | 9.5 |
| **KServerCore** | **34.1** | **34.1** | **0.0** |
| KSkill | 25.8 | 4.9 | 20.9 |
| KBuySell | 25.1 | 19.9 | 5.2 |
| KPlayerTong | 24.9 | 18.7 | 6.2 |
| KSubWorld | 23.9 | 6.3 | 17.6 |
| KProtocolProcess | 23.9 | 14.4 | 9.6 |
| **KTongLogic_GameSvr_Result** | **23.7** | **23.7** | **0.0** |

**The guild cluster is the concentrated risk.** `KTongLogic` (43.6) +
`KTongLogic_GameSvr_Result` (23.7) + `KPlayerTong` (18.7 of its 24.9) +
`KTongManagerAgent` (14.6) is ~100 KB with essentially zero source coverage —
this Linux build's guild system was written after the Windows tree diverged. It
is the largest single block of pure reverse-engineering and should be scheduled
as its own phase, not folded into general porting.

`KServerCore` at 34.1 KB / 0% is the other one, and it is worse than it looks
because it is the startup path — nothing runs until it does.

## 2. The struct probe

`tools/gen_struct_probe.py` emits a program printing `sizeof()` for every packet
struct across the five protocol headers.

```
KRelayProtocol.h    13    KProtocol.h    277
KTongProtocol.h     66    KGmProtocol.h   34
TOTAL              390 names -- 365 distinct layouts (25 tag/typedef alias pairs)
```

Both counts are real and answer different questions. 390 is how many type
*names* must compile (code uses both spellings of an aliased struct); 365 is how
many distinct *layouts* exist.

**All 390 compile and their sizes are recorded in `protocol/struct_sizes.tsv`.**
The sizes are visibly odd numbers — 5, 9, 35, 39 — which is the check that
`#pragma pack(1)` is actually in effect. Any padding would round them to
multiples of 4.

Why this matters more than it looks: these structs are `#pragma pack(1)` and get
`memcpy`'d straight onto the socket. The client is a compiled binary that cannot
be changed, so a struct one byte off is not a bug that shows up as a wrong value
— it desynchronises the stream and the connection dies. Getting all 390 to
compile and match is the Phase 0 exit criterion.

`KProtocol.h` already switches on `__linux`: without it the include is the
Windows relative path `../Sources/Core/src/GameDataDef.h`, with it the include
is a plain `"GameDataDef.h"` resolved from the include path. Someone started
this port before. `-D__linux` plus `Sources/Core/Src` on the include path takes
that branch.

Note that `KTongProtocol.h` includes nothing at all — it assumes `GameDataDef.h`
is already in the translation unit. Include order in the probe is therefore not
cosmetic.

### What the first build actually taught us

The first compile produced 184 errors. They collapsed to three causes, and two
of them were mine.

**1. The tree is not uniformly GBK, and saying it is breaks everything.** The
obvious setting is `-finput-charset=GBK`, since the comments are Chinese. It is
wrong. Measured:

| File | Decodes as |
|---|---|
| `KProtocol.h` | GBK (invalid UTF-8 at 1697) |
| `GameDataDef.h` | **UTF-8** (invalid GBK at 510) |
| `CoreUseNameDef.h` | **neither** GBK, GB18030, nor UTF-8 |

Naming a charset makes GCC run iconv over every file and fail hard on the first
byte that does not fit. The failure surfaces as one error at the `#include`
line — `failure to convert GBK to UTF-8` — which drops every type the header
defines and cascades into ~180 downstream "was not declared" errors that all
point at innocent code. Removing both charset flags fixed 178 of the 184.

Passing bytes through untouched is also the *correct* behaviour, not just the
convenient one: some of those string literals go on the wire, and the original
MSVC build emitted the source bytes verbatim.

**2. `GUID` and `POINT` were missing from compat.** Both appear by value inside
packed structs, so they are wire layouts, not conveniences. Added with a
`static_assert(sizeof(GUID) == 16)` rather than trusting it.

**3. A real bug in the Windows source.** `KProtocol.h:1384`:

```cpp
void AllocateBuffer(std::size_t size) { m_lpBuf = &std::make_unique<BYTE[]>(size); }
```

Taking the address of a temporary. MSVC accepted it; GCC rejects it. It is not
a portability wart — the `unique_ptr` dies at the end of the full expression, so
`m_lpBuf` points at freed memory. The probe only needs the header to *parse*, so
`-fpermissive` is scoped to that one target; the member gets fixed properly when
`tagSHOW_MSG_SYNC` is ported. Worth remembering as evidence that the Windows
tree is a source of code, not a source of truth.

**4. The harvester probed a commented-out struct.** `DB_PLAYERSELECT_COMMAND`
lives inside `/* ... */` in `KProtocol.h`. Regexes do not know about comments;
`gen_struct_probe.py` now strips them first (preserving newlines so the
`^`-anchored patterns still work). This is what moved the layout count from 364
to 365.

## 3. The oracle

The shipped binary is the only authority on correct behaviour. `oracle_proxy.py`
sits between client and server and records the session; `diff_capture.py`
compares two recordings. Correctness becomes a byte diff instead of an argument.

Verified by `tools/test_oracle.py` — 15 checks, all passing:

- traffic is forwarded intact and both directions are captured
- payloads survive NUL and high bytes (base64 in the capture, not text)
- two identical sessions compare equal, exit 0
- a one-byte change is located at the exact offset, exit 1
- the KSG codec round-trips 60 cases against the real `heaven_table.bin`
  (22716 bytes / 5679 entries), including 1–3 byte tails
- a known-answer vector pins it to the C++ that was verified byte-exact against
  live `bishop_y`

One genuine oddity, pinned in the test so nobody mistakes it for a bug:
`table[1] = 0x3393f600` has a zero low byte, so a 1-byte payload under key 0
XORs with zero and the cipher is a no-op. The C++ does the same.

Streams are concatenated per (connection, direction) before comparison. TCP may
split writes differently between runs; comparing record-by-record would report
those as protocol differences.

## 4. The compat layer

`compat/` maps the Win32 API the JX sources call onto POSIX. Scoped by
measurement: 55 distinct API names across 37 files that include `<windows.h>`.
It is not a general Win32 emulation and should not become one.

It compiles under `-m32` with zero errors. Decisions worth knowing:

- **`CRITICAL_SECTION` is recursive.** The JX player and NPC locks re-enter. A
  non-recursive mutex deadlocks instead of failing loudly.
- **`GetTickCount` is deliberately truncated to 32 bits** so unsigned wraparound
  matches Win32. Code that subtracts tick counts relies on that overflow.
- **`Interlocked{Increment,Decrement}` return the new value; `InterlockedExchange`
  returns the old one.** Easy to get backwards; the callers depend on it.
- **Auto-reset events signal, manual-reset events broadcast.**
- **`winsock2.h` is not in the `windows.h` umbrella**, mirroring the Win32
  ordering constraint so ported includes stay honest.

## Where the build runs

The dev host is Windows with Python 3.11 and no compiler; WSL is not installed.
Builds run on the project VPS in a container:

```bash
# one-time: get the sources onto the VPS build directory
tar --exclude=__pycache__ --exclude=build -czf - gameserver_cpp docker/gameserver-build \
    | ssh -i ~/.ssh/vltk_vps root@<vps> 'mkdir -p /root/jx-build && tar xzf - -C /root/jx-build'
cd /path/to/SwordOnline && tar -czf - Headers Sources/Core/Src \
    | ssh -i ~/.ssh/vltk_vps root@<vps> 'mkdir -p /root/jx-build/jxwin && tar xzf - -C /root/jx-build/jxwin'

# build
ssh -i ~/.ssh/vltk_vps root@<vps> \
    'cd /root/jx-build && JX_WIN_SOURCE=/root/jx-build/jxwin bash docker/gameserver-build/build.sh Debug struct_probe'
```

`/root/jx-build` is deliberately **separate from the deployed `/root/vltk-linux`**,
which carries uncommitted production config (patched IPs, runtime state). Nothing
here touches the running stack, and nothing is installed on the VPS host — the
toolchain lives entirely inside the image.

Only `Headers/` and `Sources/Core/Src/` of the Windows tree are needed so far:
15 + 187 files, 3.7 MB.

## 5. The binary describes itself

`server1/jx_linux_y` was built with `-g` and never stripped. It carries **21.3 MB
of DWARF 2** across 250 compilation units. That makes the shipped server
self-describing: the size of every struct, the name, offset and type of every
member, all recorded by the compiler that produced the binary that is running in
production today.

This replaced the planned exit route. Capturing live traffic would have shown the
total length of whatever packets a session happened to send. DWARF gives the size
*and* the internal layout of everything, needs no client, no server and no
network, and cannot be confounded by a packet that never gets exercised.

`tools/dwarf_structs.py` reads it. No external dependency — it parses the ELF
section table and the DWARF itself, because the dev host has only Python.

### Was `-g` really used everywhere?

This matters: if some translation units were compiled without it, "absent from
DWARF" would mean "not measured" rather than "not present", and the conclusion
below would be wrong. It was used everywhere. DWARF defines **8837** subprograms
with a `low_pc`; IDA found **8402** functions in the same binary. Debug info
covers more than the disassembler does, so nothing is missing.

### The result

Comparing the 390 structs our build produces against the binary:

| | count | meaning |
|---|---:|---|
| identical | **89** | the Windows header is correct for these |
| different size | **69** | the Windows header is **wrong** for these |
| absent from the binary | **232** | Windows-only packets this server never implements |

Of the 69, only 2 are a `BYTE data[1]` vs `BYTE data[]` convention difference.
The other **67 are real layout divergence** — different fields, not different
spelling. And of the 232 absent, 224 do not appear anywhere in `.debug_str`, so
the type genuinely does not exist in this server.

So for the structs the two trees share, **the Windows headers are wrong 44% of
the time** (69 of 158). They are not a description of this protocol.

### What the binary's protocol actually looks like

Every JX packet inherits from a protocol-header base, which makes the real packet
set enumerable rather than guessed at. `--packets` finds **377** of them:

| base | size | packets |
|---|---:|---:|
| `tagProtocolHeader` | 1 | 248 |
| `EXTEND_HEADER` | 2 | 124 |
| `tagProtocolHeader2` | 5 | 5 |

**236 of the 377 have no counterpart in the Windows headers at all.** Two
different header bases are in use side by side, which the single-base Windows
layout does not express.

Full layouts — 1678 fields with names, offsets, types and sizes — are in
`protocol/binary_packets.tsv`; all 1924 named aggregates are in
`protocol/binary_sizes.tsv`.

### Why these numbers can be trusted

A DWARF reader can be subtly wrong — misread a form, drop a child, shift an
offset — and still emit plausible numbers. Three independent checks say this one
is not:

1. **`--verify` on all 377 packets: 0 inconsistent.** For each, the last field
   ends exactly at `sizeof`, or is a flexible array beginning exactly at
   `sizeof`. That invariant holding across 377 unrelated structs is not something
   a broken parser produces.
2. **89 exact agreements with an independent implementation** — our GCC build of
   the Windows headers — including 28 structs of 32 bytes or more, up to a
   264-byte one. Coincidence is not available as an explanation.
3. **No source-level name is ambiguous** among the 390. 84 names do carry
   conflicting sizes, but every one is a GCC-synthesised `._NNN` for an anonymous
   aggregate, numbered from a counter that restarts per translation unit, so the
   collisions are guaranteed by construction and involve no real type.

One finding did come out of check 3 and is worth remembering: 13 *source-level*
names are ambiguous across translation units — `KINFO` `[8, 16]`,
`KItemValueInfo` `[416, 568]`, `TSendBuf` `[5, 6, 13, 14]`, `_tagSyncFileHead`
`[20, 24]`, and 9 zlib internals. None is a protocol struct, so nothing above is
affected, but `KItemValueInfo` differing by 152 bytes between two files in the
same program is a live hazard for whichever phase touches it.

## Exit criteria

- [x] All 390 struct names compile under `-m32` — sizes in `protocol/struct_sizes.tsv`
- [x] Those sizes are confirmed against what the shipped binary expects — §5
- [x] The oracle can record a session and diff two recordings
- [x] The port's scope is measured, not estimated
- [x] `build.sh` produces a binary — verified, ELF32 i386

All five are met. The second one is met in the sense that matters: it was
checked, against the strongest available evidence, and it failed. Knowing that
is the point of measuring.

## Next

**The protocol layer is no longer a porting job.** The Windows headers are wrong
for 44% of the shared structs and missing 236 packets, so porting them would
build a server that desynchronises against the real client in ways that surface
as dropped connections. `protocol/binary_packets.tsv` already holds the correct
layouts, extracted and self-checked. Phase 1 should generate the protocol header
from that table rather than adapting `KProtocol.h`.

That also re-scores the worklist. The 68%-to-reverse-engineer figure was computed
against the Windows tree; for the protocol layer specifically, DWARF has now
supplied the layouts outright, so the remaining work there is behaviour, not
structure.

Phase 1 otherwise stands: `compat` + `KServerCore` + the protocol layer, enough
to accept a connection and complete the handshake, validated against the oracle.
The handshake specifics are already reverse-engineered and recorded in the
s3relay work: 42-byte `ACCOUNT_BEGIN` with obfuscated keys at offsets 0x08/0x11,
then the chained KSG cipher. That is the Linux protocol, not the Windows 32-byte
constant-XOR form — the Windows source is actively misleading here, and using it
crash-loops the gateway. §5 is the same lesson at a larger scale.
