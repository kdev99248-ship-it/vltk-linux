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
| Struct probe generator | **done, verified** — generator runs; the *generated program has never been compiled* |
| Oracle proxy + differ | **done, verified** — 15/15 self-test checks pass, incl. the real KSG table |
| Win32 compat layer | **written, never compiled** |
| CMake + Docker toolchain | **written, never executed** |

The honest headline: **no C++ in this repo has been through a compiler.** The
dev host has Python 3.11 and nothing else — no gcc, cmake, make or docker. Every
Python tool here has actually been run and its output inspected; the C++ and the
build files have not. The first person with Docker should run
`./docker/gameserver-build/build.sh Debug struct_probe` and expect to fix things.

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
TOTAL              390 names -- 364 distinct layouts (26 tag/typedef alias pairs)
```

Both counts are real and answer different questions. 390 is how many type
*names* must compile (code uses both spellings of an aliased struct); 364 is how
many distinct *layouts* exist. The plan document's "365" was tracking the layout
count.

Why this matters more than it looks: these structs are `#pragma pack(1)` and get
`memcpy`'d straight onto the socket. The client is a compiled binary that cannot
be changed, so a struct one byte off is not a bug that shows up as a wrong value
— it desynchronises the stream and the connection dies. Getting all 390 to
compile and match is the Phase 0 exit criterion.

`KProtocol.h` already carries an `#ifndef __linux` branch that includes
`GameDataDef.h` directly, so `Sources/Core/Src` has to be on the include path.
Someone started this port before. `-D__linux` in `CMakeLists.txt` takes that
branch.

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

Decisions worth knowing:

- **`CRITICAL_SECTION` is recursive.** The JX player and NPC locks re-enter. A
  non-recursive mutex deadlocks instead of failing loudly.
- **`GetTickCount` is deliberately truncated to 32 bits** so unsigned wraparound
  matches Win32. Code that subtracts tick counts relies on that overflow.
- **`Interlocked{Increment,Decrement}` return the new value; `InterlockedExchange`
  returns the old one.** Easy to get backwards; the callers depend on it.
- **Auto-reset events signal, manual-reset events broadcast.**
- **`winsock2.h` is not in the `windows.h` umbrella**, mirroring the Win32
  ordering constraint so ported includes stay honest.

All unverified until it compiles.

## Exit criteria

- [ ] All 390 struct names compile under `-m32` and `sizeof` matches the binary
- [x] The oracle can record a session and diff two recordings
- [x] The port's scope is measured, not estimated
- [ ] `build.sh` produces a binary on a machine with Docker

## Next

Phase 1 is `compat` + `KServerCore` + the protocol layer — enough to accept a
connection and complete the handshake, validated against the oracle. The
handshake specifics are already reverse-engineered and recorded in the s3relay
work: 42-byte `ACCOUNT_BEGIN` with obfuscated keys at offsets 0x08/0x11, then
the chained KSG cipher. That is the Linux protocol, not the Windows 32-byte
constant-XOR form — the Windows source is actively misleading here, and using it
crash-loops the gateway.
