# gameserver_cpp

A Linux port of the JX Online (Võ Lâm Truyền Kỳ) game server, replacing the
shipped `server1/jx_linux_y` binary.

The strategy is **differential**: a Windows source tree for the same game
already exists, so the work is to port what it covers and reverse-engineer only
what it does not. Measuring that split is what Phase 0 is for.

```
1149 of 4040 methods (32%, 374 KB of code)  are in the Windows source  -> PORT
2891 of 4040 methods (68%, 811 KB of code)  are not                    -> RE
```

Those numbers come from `tools/symbols/worklist.tsv`, which is generated, not
estimated -- see below.

## Layout

```
compat/       Win32 -> POSIX shim. Covers the 55 API names the JX sources
              actually call, nothing more.
tools/        The measurement and validation tooling. All Python 3, no build
              step, because the dev host has no C++ toolchain.
tools/symbols/  Generated data: the IDA symbol table and everything derived
                from it.
tools/ida/    The two scripts that need IDA itself, because what they read is
              in the code and not in the debug info. Run there, output
              committed as data.
protocol/     struct_sizes.tsv    sizeof for all 390 packet structs as our build
                                  computes them, from struct_probe.
              binary_sizes.tsv    all 1924 named aggregates in the shipped
                                  binary, read from its DWARF.
              binary_packets.tsv  the real packet set -- 574 structs, 2353
                                  fields with offsets and types. This, not the
                                  Windows headers, is the protocol.
              binary_types.tsv    the 93 non-packet structs those fields refer
                                  to. Without them the packet table describes
                                  the protocol but will not compile.
              binary_enums.tsv    the 2 enums used as field types.
              binary_all_enums.tsv  all 115 enums / 1098 enumerators that
                                  survive in DWARF, for the ID cross-check.
              dispatch_c2s.tsv    the inbound dispatch table, read out of
                                  KProtocolProcess's constructor.
              send_ids.tsv        every protocol byte the binary writes, paired
                                  with the declared type it wrote it into.
src/protocol/ The protocol layer, generated from the tables above and
              committed. jx_protocol.h is the header; jx_layout.cpp is 2793
              static_asserts that it matches the binary; jx_protocol_ids.h is
              the ID table with 355 more.
src/net/      The network boundary. heaven_abi.h is the recovered ABI of
              libheaven.so and librainbow.so -- transcribed vtables, since
              neither ships a header. ksg.cpp is the wire cipher and
              ksg_table.cpp its 5679-key table, generated and committed
              because the shipped server keeps it in .rodata, not in a file.
src/core/     The server itself. KSOServer is config, sockets and the clock;
              KServerCore owns the per-client session state; KClientProcess is
              the inbound state machine, including the 17-byte login.
src/util/     KIniFile and KThreadLock.
src/main.cpp  Argument parsing, the core-dump limit, the loop.
docs/         Phase notes. Start with docs/PHASE0.md.
```

## Building

The build runs in a container, on any machine with Docker:

```bash
./docker/gameserver-build/build.sh                     # RelWithDebInfo
./docker/gameserver-build/build.sh Debug               # + ASAN/UBSAN
./docker/gameserver-build/build.sh Debug struct_probe  # one target
```

The Windows source tree is **not** vendored -- it is bind-mounted from
`../Source/Source/SwordOnline`. Point elsewhere with `JX_WIN_SOURCE=/path/...`.
Only `Headers/` and `Sources/Core/Src/` are needed so far (3.7 MB).

The Windows dev host has no compiler and no WSL, so in practice builds happen on
the project VPS in a scratch directory kept separate from the deployed stack --
see `docs/PHASE0.md` for the exact commands.

The build is 32-bit. That is a constraint, not a preference: `libheaven.so` and
`librainbow.so` ship as ELF32 i386 and the server loads them, so a 64-bit build
would mean reverse-engineering both first. Verified output:

```
ELF 32-bit LSB pie executable, Intel i386, dynamically linked, with debug_info
```

**No charset flags.** `-finput-charset=GBK` looks right and breaks the build --
the tree is mixed-encoding (`KProtocol.h` is GBK, `GameDataDef.h` is UTF-8,
`CoreUseNameDef.h` is neither). See `docs/PHASE0.md`.

## Tools

Everything here runs on a bare Python 3 install.

| Tool | What it does |
|---|---|
| `build_worklist.py` | Cross-references the 8402 IDA symbols against the Windows tree at **method** level and writes `symbols/worklist.tsv` -- the port's task list, sorted by weight. |
| `scan_lua_bindings.py` | Finds the C Lua bindings and counts how often each is called from the 6347 shipped scripts, so binding work can be ordered by real usage. |
| `gen_struct_probe.py` | Emits a C++ program printing `sizeof()` for every packet struct. |
| `dwarf_structs.py` | Reads struct layouts straight out of the shipped binary's DWARF -- sizes, field names, offsets, types. The ground truth everything else is checked against. |
| `gen_protocol.py` | Turns those tables into `src/protocol/jx_protocol.h` plus an assertion file that makes "our layout matches the binary" a compile error when it stops being true. |
| `gen_protocol_ids.py` | The other half of the wire format: joins the `c2s_PROTOCOL` enum, the dispatch table and the send-ID sweep into `jx_protocol_ids.h`, and asserts every ID against a packet type that exists. |
| `cmp_protocol_ids.py` | Puts the Windows `KProtocolDef.h` next to the binary's own enums. Reports agreement, conflicts and one-sided names separately -- 31 of the 100 shared IDs conflict. |
| `ida/dump_dispatch.py` | Runs inside IDA. Reads the 95 assigned slots of `ProcessFunc[]` out of `KProtocolProcess`'s constructor -- there is no switch to read, the mapping is the array. |
| `ida/dump_send_ids.py` | Runs inside IDA. Decompiles all 8401 functions and records every protocol byte the server writes together with the declared type it wrote it into, which is the only trace the outbound IDs leave. |
| `gen_ksg_table.py` | Emits the 5679-key cipher table as committed C++, asserting the size and printing the sha256 of what it read. |
| `check_ksg.py` | Diffs the C++ cipher against the independent Python one in `oracle_proxy.py`, using vectors printed by the `ksg_vectors` target. Found a 2³² wraparound bug -- in the Python. |
| `oracle_proxy.py` | TCP capture proxy. Records a session against the old server, then the new one. |
| `diff_capture.py` | Compares two captures and locates the first divergence. Exit 1 on any difference. |
| `test_oracle.py` | Self-test for the two above. Run it before trusting them. |

Two of the tools are C++ rather than Python, because they have to run against
the shipped 32-bit libraries:

| Target | What it does |
|---|---|
| `ksg_vectors` | Prints 96 cipher vectors for `check_ksg.py`, and checks the cipher is symmetric over its own output. |
| `login_probe` | Drives a real login against the ported server *through `librainbow.so`*, the shipped client engine -- so the framing and key handling are the real ones and only `KCoder2` comes from this tree. |

### Method-level, not class-level

The worklist matches `Class::Method`, and this matters more than it sounds. A
class-name match is worthless: `KItemList` looks "covered" in the Windows tree,
but the only hit is `friend class KItemList;` -- a forward declaration with no
body behind it. Counting classes put coverage near 72%; counting methods put it
at 32%. The second number is the real one.

### The oracle

The shipped binary is the only authority on correct behaviour, so correctness is
established by comparison, not by reading code:

```bash
# 1. record the reference
python3 tools/oracle_proxy.py --listen 0.0.0.0:5560 --target <old-server>:5560 \
    --out captures/login-old.jsonl --label old
# ... point the client at the proxy, log in, do the thing ...

# 2. record the port doing the same thing
python3 tools/oracle_proxy.py --listen 0.0.0.0:5560 --target <new-server>:5560 \
    --out captures/login-new.jsonl --label new

# 3. compare
python3 tools/diff_capture.py captures/login-old.jsonl captures/login-new.jsonl
```

The differ concatenates per (connection, direction) before comparing, because
TCP is free to split writes differently between two runs and record-by-record
comparison would report those as differences.

`--ksg-table config/reference/heaven_table.bin` adds a decoded view to the
verbose output. It never changes what is captured -- the capture is always the
bytes on the wire, so a decode bug cannot corrupt the evidence.

### The binary is the specification

`server1/jx_linux_y` ships with 21.3 MB of DWARF, so it describes its own types.
That closed the last exit criterion, and the answer was not the expected one:

```bash
python3 tools/dwarf_structs.py server1/jx_linux_y --verify \
    --compare protocol/struct_sizes.tsv
```

```
89 identical · 69 different · 232 the binary has never heard of
```

For the structs both trees define, the Windows headers are wrong 44% of the time.
`--packets` enumerates the real set instead -- 574 structs, 236 of which the
Windows headers do not contain. A packet is one that inherits, at any depth, from
a protocol-header base, or one whose first member is the protocol byte itself.
Details and the checks behind the numbers are in `docs/PHASE0.md` §5 and
`docs/PHASE1.md` §1.

### The protocol layer is generated, and the compiler checks it

Given that, the protocol header is not written by hand and not ported. It is
generated from the tables above, and every size and offset in it is asserted:

```bash
python3 tools/gen_protocol.py     protocol/ -o src/protocol/
python3 tools/gen_protocol_ids.py protocol/ -o src/protocol/
./docker/gameserver-build/build.sh RelWithDebInfo jx_protocol
```

```
666 types, 2756 fields · 656 size assertions, 2137 offset assertions
                       · 355 protocol-ID assertions
[100%] Built target jx_protocol
```

Everything is `#pragma pack(1)` with the padding emitted explicitly from the
offsets the binary reports, so the layout never depends on this compiler
agreeing with the one that built the server. It would not always agree:
`VIEW_OTHER_DETAIL_INFO` has members ending at 139 and a `sizeof` of 140.

A clean build of 2793 assertions is only evidence if the assertions run, so
`negative_control` makes five of the same claims off by a known amount and is
expected to fail:

```bash
./docker/gameserver-build/build.sh RelWithDebInfo negative_control   # 5 errors
```

The five are the layout hazards worth a control: multiple inheritance under
`pack(1)`, trailing alignment padding, internal padding, a multi-dimensional
array DWARF records as one DIE with two subranges, and an anonymous union GCC
flattened into its parent. The last two are bugs this phase actually had.

### The handshake, end to end

`jx_gameserver` starts, opens its socket and completes the client login. The
test uses the shipped client engine as the other half, so nothing hand-rolls the
wire format, and both processes run in one container on `--network none`:

```bash
./docker/gameserver-build/build.sh RelWithDebInfo jx_gameserver
./docker/gameserver-build/build.sh RelWithDebInfo login_probe
# then, in a throwaway container with libheaven.so, librainbow.so, servercfg.ini
./jx_gameserver 7666 &
./login_probe 127.0.0.1 7666 4 17    # valid   -> accepted, silent
./login_probe 127.0.0.1 7666 4 16    # short   -> rejected, disconnected
```

The rejection is the case that proves something:

```
[error]NetServer:Invalid Protocol Size! protocol(66) expect(17) actual(16)
[ShutdownClient]	shut down client(1) - ip(127.0.0.1 : 49398) because invalid protocol!
```

Those three numbers can only appear together if heaven decoded the packet with
our `KCoder2`, the first byte arrived as 66, and the recovered size table says
protocol 66 is 17 bytes. The valid login gets past the same gate and is then
accepted in silence -- which is what the shipped server also does with an empty
player set. Details in `docs/PHASE1.md` §8.

## Status

**Phase 0 closed. Phase 1 closed except for the oracle diff.** The build
produces an ELF32 i386 binary that runs, listens, and completes the 17-byte
`c2s_logiclogin` handshake. Under it: a protocol layer generated from the shipped
binary's own DWARF and proven byte-identical at compile time; the ID table,
recovered from the code because the client-facing IDs are `#define`s that leave
no trace in DWARF; the KSG cipher, agreeing with an independent implementation on
96 vectors.

What Phase 1 does **not** have is a byte diff against a running `jx_linux_y`.
That is blocked rather than skipped: the shipped binary refuses to start without
its five outbound links to gateway, database, transfer, chat and tong, so an
oracle instance is Phase 2 in its entirety. This build starts without them, which
is the one deliberate behavioural difference and the reason Phase 1 could be
tested at all. See `docs/PHASE1.md` §9 for the full list of what is stubbed.
