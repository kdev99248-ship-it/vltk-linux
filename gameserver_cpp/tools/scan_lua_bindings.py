#!/usr/bin/env python3
"""Cross-check the binary's Lua binding functions against the scripts that call them.

Every binding in jx_linux_y is a C function `int LuaXxx(lua_State*)`. The name the
scripts see is the same minus the `Lua` prefix -- this script proves that by
counting how many of those stripped names actually appear as calls in script/.

Two outputs, both of which drive the port order:

  lua_bindings.tsv  one row per binding: C symbol, Lua name, call count in script/
  lua_unbound.tsv   names the scripts call that no binding in the binary provides
                    (these come from Lua-side definitions, not from C)

Usage:
    python3 tools/scan_lua_bindings.py <path-to-server1/script> [-o tools/symbols]
"""
import argparse
import collections
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SYMBOLS = os.path.join(HERE, "symbols", "ida_funcs.tsv")

# _Z16LuaGetServerNameP9lua_State -> the demangled column gives us LuaGetServerName
BINDING_RE = re.compile(r"^(Lua[A-Za-z_]\w*)\(lua_State\s*\*\)$")
CALL_RE = re.compile(r"\b([A-Za-z_]\w*)\s*\(")


def read_bindings(path):
    """C symbol -> code size, for every `int LuaXxx(lua_State*)` in the binary."""
    out = {}
    with open(path, "r", encoding="utf-8") as fh:
        next(fh)
        for line in fh:
            parts = line.rstrip("\n").split("\t")
            if len(parts) != 4:
                continue
            _addr, size, _mangled, dem = parts
            m = BINDING_RE.match(dem.strip())
            if m:
                out[m.group(1)] = int(size)
    return out


def scan_calls(script_root):
    """Count every identifier used in call position across all .lua files."""
    calls = collections.Counter()
    files = 0
    for dirpath, _dirnames, filenames in os.walk(script_root):
        for fn in filenames:
            if not fn.lower().endswith(".lua"):
                continue
            path = os.path.join(dirpath, fn)
            try:
                with open(path, "r", encoding="utf-8", errors="replace") as fh:
                    text = fh.read()
            except OSError:
                continue
            files += 1
            for name in CALL_RE.findall(text):
                calls[name] += 1
    return calls, files


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("script_root", help="path to server1/script")
    ap.add_argument("-o", "--outdir", default=os.path.join(HERE, "symbols"))
    args = ap.parse_args()

    if not os.path.isdir(args.script_root):
        sys.exit(f"not a directory: {args.script_root}")

    bindings = read_bindings(SYMBOLS)
    calls, nfiles = scan_calls(args.script_root)

    rows = []
    for sym, size in bindings.items():
        lua_name = sym[3:]  # strip the "Lua" prefix
        rows.append((sym, lua_name, size, calls.get(lua_name, 0)))
    rows.sort(key=lambda r: (-r[3], -r[2], r[0]))

    os.makedirs(args.outdir, exist_ok=True)
    out_b = os.path.join(args.outdir, "lua_bindings.tsv")
    with open(out_b, "w", encoding="utf-8", newline="\n") as fh:
        fh.write("c_symbol\tlua_name\tcode_bytes\tcalls_in_scripts\n")
        for r in rows:
            fh.write("\t".join(str(x) for x in r) + "\n")

    # Names the scripts call that the binary does not export as a binding.
    known = {r[1] for r in rows}
    lua_keywords = {
        "if", "for", "while", "function", "return", "and", "or", "not", "do",
        "then", "end", "local", "else", "elseif", "in", "repeat", "until",
        "print", "type", "pairs", "ipairs", "tonumber", "tostring", "format",
        "string", "table", "math", "assert", "error", "pcall", "next", "unpack",
    }
    unbound = [(n, c) for n, c in calls.items()
               if n not in known and n not in lua_keywords and c >= 5]
    unbound.sort(key=lambda x: -x[1])
    out_u = os.path.join(args.outdir, "lua_unbound.tsv")
    with open(out_u, "w", encoding="utf-8", newline="\n") as fh:
        fh.write("lua_name\tcalls_in_scripts\n")
        for n, c in unbound:
            fh.write(f"{n}\t{c}\n")

    used = [r for r in rows if r[3] > 0]
    print(f"scanned {nfiles} .lua files")
    print(f"bindings in binary      : {len(rows)}")
    print(f"  called by scripts     : {len(used)}  ({100*len(used)//max(len(rows),1)}%)  <- naming convention holds")
    print(f"  never called          : {len(rows)-len(used)}")
    print(f"script names with no C binding (>=5 calls): {len(unbound)}")
    print(f"wrote {out_b}")
    print(f"wrote {out_u}")


if __name__ == "__main__":
    main()
