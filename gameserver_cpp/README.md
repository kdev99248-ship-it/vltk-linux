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
protocol/     struct_sizes.tsv    sizeof for all 390 packet structs as our build
                                  computes them, from struct_probe.
              binary_sizes.tsv    all 1924 named aggregates in the shipped
                                  binary, read from its DWARF.
              binary_packets.tsv  the real packet set -- 377 structs, 1678
                                  fields with offsets and types. This, not the
                                  Windows headers, is the protocol.
              binary_types.tsv    the 36 non-packet structs those fields refer
                                  to. Without them the packet table describes
                                  the protocol but will not compile.
              binary_enums.tsv    the 2 enums used as field types.
src/protocol/ The protocol layer, generated from the three tables above by
              tools/gen_protocol.py and committed. jx_protocol.h is the header;
              jx_layout.cpp is 1837 static_asserts that it matches the binary.
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
| `oracle_proxy.py` | TCP capture proxy. Records a session against the old server, then the new one. |
| `diff_capture.py` | Compares two captures and locates the first divergence. Exit 1 on any difference. |
| `test_oracle.py` | Self-test for the two above. Run it before trusting them. |

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
`--packets` enumerates the real set instead -- 377 structs, found by their
inheritance from a protocol-header base, 236 of which the Windows headers do not
contain. Details and the checks behind the numbers are in `docs/PHASE0.md` §5.

### The protocol layer is generated, and the compiler checks it

Given that, the protocol header is not written by hand and not ported. It is
generated from the tables above, and every size and offset in it is asserted:

```bash
python3 tools/gen_protocol.py protocol/ -o src/protocol/
./docker/gameserver-build/build.sh RelWithDebInfo jx_protocol
```

```
412 types, 1827 fields · 408 size assertions, 1429 offset assertions
[100%] Built target jx_protocol
```

Everything is `#pragma pack(1)` with the padding emitted explicitly from the
offsets the binary reports, so the layout never depends on this compiler
agreeing with the one that built the server. It would not always agree:
`VIEW_OTHER_DETAIL_INFO` has members ending at 139 and a `sizeof` of 140.

A clean build of 1837 assertions is only evidence if the assertions run, so
`negative_control` makes three of the same claims off by one and is expected to
fail:

```bash
./docker/gameserver-build/build.sh RelWithDebInfo negative_control   # 3 errors
```

## Status

**Phase 0 closed. Phase 1 in progress.** The build produces an ELF32 i386
binary, and the protocol layer now exists: generated from the shipped binary's
own DWARF and proven byte-identical to it at compile time. Still open in Phase 1
are the protocol ID table -- the client-facing IDs are `#define`s and leave no
trace in DWARF, so they need RE -- then `KServerCore` and the handshake. See
`docs/PHASE1.md`.
