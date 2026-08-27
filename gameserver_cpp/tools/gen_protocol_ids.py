#!/usr/bin/env python3
"""Build the protocol ID header, and cross-check the three sources for it.

The packet *layouts* came out of DWARF and the compiler now checks them. The
*IDs* -- which byte in the header selects which packet -- are a separate
question with three possible answers, of unequal standing:

  1. `c2s_PROTOCOL` in the binary's DWARF.  The enum the shipped server was
     compiled with. 164 names.
  2. `KProtocolProcess::ProcessFunc[]`, filled in the constructor.  The array
     ProcessNetMsg indexes with the raw protocol byte, so this is the dispatch
     itself rather than a description of it. 110 slots.
  3. `KProtocolDef.h` in the Windows tree.  A different version of the game,
     already measured as unreliable in Phase 0.

(1) and (2) are independent artifacts of the same build, so where they agree
the ID is settled. (3) gets compared and reported, never used.

    python3 tools/gen_protocol_ids.py protocol/ -o src/protocol/ \\
        [--header ../../Source/Source/SwordOnline/Headers/KProtocolDef.h]
"""
from __future__ import annotations

import argparse
import os
import re
import sys
from collections import OrderedDict

ENUM = "c2s_PROTOCOL"

# Handler name -> enum name is not a rename anyone wrote down; it is two people
# naming the same protocol independently, one in CamelCase and one in a lowercase
# run-on. `PlayerEatItem` / `c2s_playereatitem` is the easy case; `RemoveRole` /
# `c2s_removeplayer` and `ItemRepair` / `c2s_repairitem` are why a plain string
# compare reports 25 mismatches that are all the same protocol.
#
# So: split the handler on case, drop the words that are pure convention, and ask
# how many of the rest appear in the enumerator. All of them means the two agree.
# Some of them is a real difference of wording, worth a human but not alarming.
# None of them is the case that would matter.
NOISE = frozenset(("c2s", "on", "command", "msg", "protocol", "request", "req"))


def tokens(handler: str) -> "list[str]":
    parts = re.findall(r"[A-Z]+(?![a-z])|[A-Z][a-z0-9]*|[a-z0-9]+", handler)
    kept = [p.lower() for p in parts if p.lower() not in NOISE]
    return kept or [handler.lower()]


def agreement(handler: str, enum_name: str) -> "tuple[int, int]":
    """(tokens found in the enumerator, tokens looked for)."""
    hay = re.sub(r"[^a-z0-9]", "", enum_name.lower())
    toks = tokens(handler)
    return sum(1 for t in toks if t in hay), len(toks)


def read_enums(path: str) -> "dict[str, OrderedDict[str, int]]":
    out: dict[str, OrderedDict[str, int]] = {}
    with open(path, encoding="utf-8") as fh:
        next(fh)
        for row in fh:
            enum, _size, name, val = row.rstrip("\n").split("\t")
            out.setdefault(enum, OrderedDict())[name] = int(val)
    return out


def read_dispatch(path: str) -> "dict[int, str]":
    """Slot -> handler for the main ProcessFunc table. 0 means retired."""
    out: dict[int, str] = {}
    with open(path, encoding="utf-8") as fh:
        for row in fh:
            if row.startswith("#") or row.startswith("table\t"):
                continue
            table, idx, handler = row.rstrip("\n").split("\t")
            if table == "ProcessFunc":
                out[int(idx)] = handler
    return out


def read_header_enum(path: str, want: str) -> "OrderedDict[str, int]":
    """Pull one enum out of the GBK-ish Windows header. Best effort by design."""
    text = open(path, "rb").read().decode("gbk", errors="replace")
    consts = {m.group(1): int(m.group(2))
              for m in re.finditer(r"const\s+UINT\s+(\w+)\s*=\s*(\d+)", text)}

    body = re.search(r"enum\s+" + re.escape(want) + r"\s*\{(.*?)\}", text, re.S)
    if not body:
        return OrderedDict()

    vals: OrderedDict[str, int] = OrderedDict()
    nxt = 0
    for line in body.group(1).splitlines():
        line = line.split("//")[0].strip()
        m = re.match(r"^(\w+)\s*(?:=\s*([^,]+?))?\s*,?$", line)
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
            elif expr in vals:
                nxt = vals[expr]
            else:
                continue
        vals[name] = nxt
        nxt += 1
    return vals


def emit(path: str, enum: "OrderedDict[str, int]", dispatch: "dict[int, str]",
         reworded: "list[tuple[int, str, str, int, int]]") -> None:
    live = {i: h for i, h in dispatch.items() if h != "0"}
    retired = sorted(i for i, h in dispatch.items() if h == "0")

    # Emit in the enum's own order, not sorted by value: several enumerators
    # share a value (c2s_clientbegin == c2s_login and so on), and reordering
    # would turn a boundary marker into the name of a real protocol.
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        w = fh.write
        w("// Client-to-server protocol IDs. GENERATED -- do not edit.\n"
          "//\n"
          "//   python3 tools/gen_protocol_ids.py protocol/ -o src/protocol/\n"
          "//\n"
          "// Read out of the shipped binary two independent ways: the\n"
          "// c2s_PROTOCOL enum in its DWARF, and the ProcessFunc[] table its\n"
          "// KProtocolProcess constructor fills, which is what ProcessNetMsg\n"
          "// indexes with the first byte of the message. The Windows\n"
          "// KProtocolDef.h is a different version of the game and disagrees\n"
          "// about 31 of these; it was not used. See docs/PHASE1.md.\n"
          "#pragma once\n\n"
          "enum c2s_PROTOCOL\n{\n")
        seen: set[int] = set()
        for name, val in enum.items():
            if val in seen:
                note = "   // same value, boundary marker"
            elif val in retired:
                note = "   // explicitly nulled: handled before KProtocolProcess"
            elif val in live:
                note = f"   // -> KProtocolProcess::{live[val]}"
            else:
                note = "   // not in ProcessFunc[]"
            seen.add(val)
            w(f"    {name:<44} = {val:>3},{note}\n")
        w("};\n\n")

        w("// Two notes on the annotations above.\n"
          "//\n"
          "// `not in ProcessFunc[]` is not the same as unhandled. ProcessNetMsg\n"
          "// is the last stop in the pipeline, and a message only reaches it if\n"
          "// KClientProcess::ProcessMessage passed it on: everything below 64 is\n"
          "// account and gateway traffic settled long before, and the login-phase\n"
          "// protocols are consumed by ProcessLoginProtocol.\n"
          "//\n"
          "// `explicitly nulled` means the constructor memsets the array and then\n"
          "// writes 0 over these slots again, which is only worth doing to say\n"
          "// something. c2s_ping is the clearest case: KClientProcess handles it\n"
          "// directly, so the null is what stops it reaching a second handler.\n"
          "//\n"
          "// A protocol byte in neither set reaches the `Unhandle Protocol %d`\n"
          "// printf and nothing else.\n")
        w(f"#define JX_C2S_HANDLER_COUNT {len(live)}\n")
        w(f"#define JX_C2S_MIN_HANDLED   {min(live)}\n")
        w(f"#define JX_C2S_MAX_HANDLED   {max(live)}\n")

        if reworded:
            w("\n// Slots where the handler and the enumerator name the same\n"
              "// protocol differently. The ID is not in doubt -- both sources\n"
              "// agree on that -- only the wording:\n")
            for val, handler, name, hit, total in reworded:
                w(f"//   {val:>3}  {handler:<30} {name:<34} {hit}/{total}\n")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("tables", help="directory holding the protocol/ TSVs")
    ap.add_argument("-o", "--out", default=".", help="where to write the header")
    ap.add_argument("--header", help="KProtocolDef.h, for the comparison report")
    args = ap.parse_args()

    enums = read_enums(os.path.join(args.tables, "binary_all_enums.tsv"))
    if ENUM not in enums:
        sys.exit(f"{ENUM} is not in binary_all_enums.tsv -- regenerate it with "
                 f"dwarf_structs.py --enums ... --all-enums")
    enum = enums[ENUM]
    dispatch = read_dispatch(os.path.join(args.tables, "dispatch_c2s.tsv"))

    by_id: dict[int, str] = {}
    for name, val in enum.items():
        by_id.setdefault(val, name)

    live = {i: h for i, h in dispatch.items() if h != "0"}
    print(f"enum {ENUM}: {len(enum)} names, {len(by_id)} distinct values")
    print(f"dispatch:    {len(live)} handlers, "
          f"{len(dispatch) - len(live)} retired slots")

    # --- the cross-check: do the two binary sources describe the same thing? --
    orphans = sorted(i for i in live if i not in by_id)
    full, reworded, unrelated = 0, [], []
    for val, handler in sorted(live.items()):
        name = by_id.get(val)
        if name is None:
            continue
        hit, total = agreement(handler, name)
        if hit == total:
            full += 1
        elif hit:
            reworded.append((val, handler, name, hit, total))
        else:
            unrelated.append((val, handler, name, hit, total))

    print("\ncross-check, enum vs dispatch table:")
    print(f"  handler slot has an enumerator     {len(live) - len(orphans):4}")
    print(f"  ... names agree                    {full:4}")
    print(f"  ... same protocol, other wording   {len(reworded):4}")
    print(f"  ... nothing in common, LOOK        {len(unrelated):4}")
    print(f"  handler slot with NO enumerator    {len(orphans):4}")
    for val, handler, name, hit, total in reworded + unrelated:
        mark = " <-- " if not hit else "     "
        print(f"    {val:>3}{mark}{handler:<30} enum says {name:<34} {hit}/{total}")

    if orphans or unrelated:
        print("\n  A handler with no enumerator, or one whose name has nothing in\n"
              "  common with it, means the two sources are describing different\n"
              "  things. Resolve before relying on the ID.")

    if args.header:
        win = read_header_enum(args.header, ENUM)
        agree = sum(1 for n, v in win.items() if enum.get(n) == v)
        diff = sorted(n for n, v in win.items() if n in enum and enum[n] != v)
        print(f"\nWindows KProtocolDef.h, for reference only:")
        print(f"  {len(win)} names, {agree} agree, {len(diff)} DISAGREE, "
              f"{len(win) - agree - len(diff)} absent from the binary")
        if diff:
            print("  " + ", ".join(f"{n}({win[n]}!={enum[n]})" for n in diff[:6])
                  + (" ..." if len(diff) > 6 else ""))

    os.makedirs(args.out, exist_ok=True)
    out = os.path.join(args.out, "jx_protocol_ids.h")
    emit(out, enum, dispatch, reworded)
    print(f"\nwrote {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
