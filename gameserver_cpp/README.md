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
protocol/     struct_sizes.tsv -- sizeof for all 390 packet structs, produced
              by struct_probe. The reference the port must not drift from.
src/          The port itself (Phase 1 onward).
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

## Status

Phase 0, nearly closed. The build works and produces an ELF32 i386 binary; all
390 protocol structs compile and their sizes are recorded. The one open exit
criterion is confirming those sizes against the shipped binary. See
`docs/PHASE0.md`.
