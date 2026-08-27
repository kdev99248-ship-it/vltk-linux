#!/usr/bin/env python3
"""Cross-check the protocol ID enums in the Windows header against the binary.

The packet layouts came out of DWARF. The IDs are a separate question: which
byte in the header selects which struct. Some of that mapping is in DWARF too --
an enum survives if the binary uses it as a *type* somewhere -- and the rest is
only in the Windows header, which Phase 0 measured as unreliable.

So: parse both, and report the three populations separately. Agreement is
evidence. Disagreement is a finding. A name that exists in only one of them is
neither until someone looks at the code.

    python3 tools/cmp_protocol_ids.py <all_enums.tsv> <KProtocolDef.h>
"""
from __future__ import annotations

import argparse
import re
import sys
from collections import OrderedDict

# The header is GBK-with-exceptions (Phase 0), and none of it matters here:
# every line we care about is ASCII. Decode permissively and move on.
ENUM_RE = re.compile(r"^\s*enum\s+(\w+)")
# `name = 42,` / `name = 0x2a,` / `name = other_name,` / bare `name,`
MEMBER_RE = re.compile(r"^\s*(\w+)\s*(?:=\s*([^,}]+?))?\s*(?:,|$|\})")


def parse_header(path: str) -> dict[str, "OrderedDict[str, int]"]:
    """Read the C enums out of a header, resolving implicit numbering.

    Values can be a literal, a previously defined constant, or absent, in which
    case C says "one more than the last one". All three appear in this file.
    """
    text = open(path, "rb").read().decode("gbk", errors="replace")
    consts: dict[str, int] = {}
    for m in re.finditer(r"const\s+UINT\s+(\w+)\s*=\s*(\d+)", text):
        consts[m.group(1)] = int(m.group(2))

    enums: dict[str, OrderedDict[str, int]] = {}
    cur: OrderedDict[str, int] | None = None
    depth = 0
    for line in text.splitlines():
        line = line.split("//")[0]
        if cur is None:
            m = ENUM_RE.match(line)
            if m:
                cur, depth = OrderedDict(), 0
                enums[m.group(1)] = cur
                nxt = 0
            continue

        depth += line.count("{")
        if "}" in line:
            cur = None
            continue
        if depth == 0 or not line.strip():
            continue

        m = MEMBER_RE.match(line)
        if not m:
            continue
        name, expr = m.group(1), m.group(2)
        if expr is not None:
            expr = expr.strip()
            if re.fullmatch(r"-?\d+", expr):
                nxt = int(expr)
            elif re.fullmatch(r"0[xX][0-9a-fA-F]+", expr):
                nxt = int(expr, 16)
            elif expr in consts:
                nxt = consts[expr]
            elif expr in cur:
                nxt = cur[expr]
            else:
                print(f"  ! {name} = {expr!r}: cannot resolve, skipping enum member",
                      file=sys.stderr)
                continue
        cur[name] = nxt
        nxt += 1
    return enums


def parse_binary(path: str) -> dict[str, "OrderedDict[str, int]"]:
    """Read the enums dwarf_structs.py --all-enums pulled out of the binary."""
    enums: dict[str, OrderedDict[str, int]] = {}
    with open(path, encoding="utf-8") as fh:
        next(fh)
        for row in fh:
            enum, _size, name, val = row.rstrip("\n").split("\t")
            enums.setdefault(enum, OrderedDict())[name] = int(val)
    return enums


def compare(name: str, win: "OrderedDict[str, int]",
            binary: "OrderedDict[str, int]") -> int:
    """Report one enum. Returns the number of value conflicts."""
    same = [n for n in win if n in binary and win[n] == binary[n]]
    diff = [n for n in win if n in binary and win[n] != binary[n]]
    win_only = [n for n in win if n not in binary]
    bin_only = [n for n in binary if n not in win]

    print(f"\n{name}   header {len(win)}   binary {len(binary)}")
    print(f"  agree            {len(same):4}")
    print(f"  DISAGREE         {len(diff):4}")
    print(f"  header only      {len(win_only):4}")
    print(f"  binary only      {len(bin_only):4}")

    for n in diff:
        print(f"    ! {n}: header says {win[n]}, binary says {binary[n]}")
    for n in bin_only:
        print(f"    + {n} = {binary[n]}  (binary only -- not in the header)")
    if win_only:
        head = ", ".join(win_only[:8])
        tail = " ..." if len(win_only) > 8 else ""
        print(f"    - header only: {head}{tail}")
    return len(diff)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("binary_enums", help="TSV from dwarf_structs.py --all-enums")
    ap.add_argument("header", help="path to KProtocolDef.h")
    args = ap.parse_args()

    win = parse_header(args.header)
    binary = parse_binary(args.binary_enums)

    print(f"header: {len(win)} enums   binary: {len(binary)} enums")

    conflicts = 0
    shared = [n for n in win if n in binary]
    for n in shared:
        conflicts += compare(n, win[n], binary[n])

    absent = [n for n in win if n not in binary]
    if absent:
        print("\nIn the header, absent from the binary's DWARF:")
        for n in absent:
            print(f"  {n:28} {len(win[n]):4} values")
        print("\n  Absent is not the same as unused: GCC only emits an enum type\n"
              "  when something is declared with it. These have to be confirmed\n"
              "  against the code that uses the constants.")

    print(f"\n{'CONFLICTS: ' + str(conflicts) if conflicts else 'no value conflicts'}")
    return 1 if conflicts else 0


if __name__ == "__main__":
    sys.exit(main())
