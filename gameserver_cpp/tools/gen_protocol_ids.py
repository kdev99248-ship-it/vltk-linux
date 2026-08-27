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

That covers the client-to-server direction. The other way there is no enum at
all: `s2c_PROTOCOL` is used only as a source of constants, and a constant leaves
no type behind for GCC to describe -- the name is nowhere in the server, the
relay or libheaven. What does survive is the server writing the ID, and DWARF
saying what it wrote it into, so the fourth source is:

  4. `protocol/send_ids.tsv`, every `x.cProtocol = N` in the binary paired with
     the declared type of `x`. Observed, not named: it gives the byte for a
     packet without giving the enumerator it was spelled with.

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


def read_packet_names(path: str) -> "dict[str, str]":
    """Every name a packet struct answers to -> the struct itself.

    A struct routinely has several typedef names and the code picks one per use
    site, so the name the send-ID sweep reports is often not the name the layout
    table is keyed on. One 5-byte struct is NPC_REMOVE_SYNC, NPC_REQUEST_FAIL,
    NPC_SIT_SYNC and NPC_STATE_REQUEST_COMMAND, with a different protocol byte
    under each -- which is also why the IDs are keyed on the name used, not on
    the struct.
    """
    out: dict[str, str] = {}
    with open(path, encoding="utf-8") as fh:
        next(fh)
        for row in fh:
            r = row.rstrip("\n").split("\t")
            out[r[0]] = r[0]
            for a in r[1].split(","):
                if a:
                    out[a] = r[0]
    return out


def read_send_ids(path: str) -> "tuple[dict, dict]":
    """(name -> {field: {value}}, name -> {function}) from the IDA sweep."""
    vals: dict[str, dict[str, set]] = {}
    where: dict[str, set] = {}
    with open(path, encoding="utf-8") as fh:
        for row in fh:
            if row.startswith("#") or row.startswith("struct\t"):
                continue
            name, field, value, func, _count = row.rstrip("\n").split("\t")
            # The IDs are signed char in the source: cProtocol = -99 is 157 on
            # the wire, and the packet whose handler is at slot 157 confirms it.
            vals.setdefault(name, {}).setdefault(field, set()).add(int(value) & 0xFF)
            where.setdefault(name, set()).add(func)
    return vals, where


def demangle(sym: str) -> str:
    """Enough of the Itanium ABI to get `Class::method` out of a symbol."""
    if not sym.startswith("_Z"):
        return sym
    i = 2
    nested = i < len(sym) and sym[i] == "N"
    if nested:
        i += 1
    parts = []
    while i < len(sym) and sym[i].isdigit():
        j = i
        while j < len(sym) and sym[j].isdigit():
            j += 1
        n = int(sym[i:j])
        parts.append(sym[j:j + n])
        i = j + n
        if not nested:
            break
    return "::".join(parts) if parts else sym


def emit_send(fh, vals: dict, where: dict, packets: "dict[str, str]") -> "tuple":
    """Write the observed s2c/relay IDs. Returns (single, extended, ambiguous)."""
    single, extended, ambiguous, unknown = {}, {}, {}, []
    for name, fields in sorted(vals.items()):
        if name not in packets:
            unknown.append(name)
            continue
        if any(len(v) > 1 for v in fields.values()):
            ambiguous[name] = fields
        elif "ProtocolFamily" in fields and "ProtocolID" in fields:
            extended[name] = (next(iter(fields["ProtocolFamily"])),
                              next(iter(fields["ProtocolID"])))
        else:
            for f in ("cProtocol", "ProtocolType"):
                if f in fields:
                    single[name] = next(iter(fields[f]))
                    break

    w = fh.write
    w("\n// ---- server-to-client and relay IDs -----------------------------\n"
      "//\n"
      "// Observed, not named. There is no s2c_PROTOCOL enum to recover: the\n"
      "// server only ever uses those constants as constants, and a constant\n"
      "// leaves nothing in DWARF. So these come from the other end -- every\n"
      "// place the binary writes a protocol byte, paired with the declared\n"
      "// type of what it wrote into. The comment on each line is a function\n"
      "// that does it, which is where to look to check one.\n"
      "//\n"
      "// The name is the typedef the code used at that site, not necessarily\n"
      "// the struct's own name: several packets share a layout and differ only\n"
      "// in which name -- and so which ID -- a caller reaches for.\n"
      "//\n"
      "//   JX_ID(T)      the byte in T's one-byte header\n"
      "//   JX_FAMILY(T)  ProtocolFamily, for the EXTEND_HEADER packets\n"
      "//   JX_SUBID(T)   ProtocolID, likewise\n"
      "//\n"
      "// Absent here means unobserved, not unused: a packet the server never\n"
      "// builds in code the decompiler could read has no row. These cover\n"
      f"// {len({packets[n] for n in single} | {packets[n] for n in extended})}"
      f" of the {len(set(packets.values()))} packet structs, under"
      f" {len(single) + len(extended)} names.\n"
      "#define JX_ID(T)     JX_ID_##T\n"
      "#define JX_FAMILY(T) JX_FAMILY_##T\n"
      "#define JX_SUBID(T)  JX_SUBID_##T\n\n")

    for name, val in sorted(single.items()):
        src = demangle(sorted(where[name])[0])
        w(f"#define JX_ID_{name:<42} {val:>3}   // {src}\n")

    w("\n// EXTEND_HEADER packets: the family byte selects the subsystem and the\n"
      "// ID byte the message within it.\n")
    for name, (fam, sub) in sorted(extended.items()):
        src = demangle(sorted(where[name])[0])
        w(f"#define JX_FAMILY_{name:<38} {fam:>3}   // {src}\n")
        w(f"#define JX_SUBID_{name:<39} {sub:>3}\n")

    if ambiguous:
        w("\n// Written with more than one value. Not a contradiction to resolve\n"
          "// by picking one -- a struct reused for several protocols is normal\n"
          "// here, and which one applies depends on the call site. No macro is\n"
          "// emitted; read the functions.\n")
        for name, fields in sorted(ambiguous.items()):
            got = "  ".join(f"{f}={sorted(v)}" for f, v in sorted(fields.items()))
            w(f"//   {name:<32} {got}\n")
            for func in sorted(where[name])[:4]:
                w(f"//       {demangle(func)}\n")

    if unknown:
        w("\n// Written by the server but not in the packet table -- these are the\n"
          "// bare header types, filled in by code that forwards a message it did\n"
          "// not build:\n")
        for name in unknown:
            w(f"//   {name}\n")
    return single, extended, ambiguous


def emit_send_checks(path: str, single: dict, extended: dict) -> int:
    """Tie the ID table to the layout table at compile time.

    A macro proves nothing on its own -- it is text until something uses it.
    Naming the packet type next to its ID makes the two tables one fact: rename
    a struct in jx_protocol.h, or key an ID on a name that no longer exists, and
    this file stops compiling. It is also the only thing that checks the IDs are
    bytes, which matters because they are signed char in the original source and
    arrive here as -99 rather than 157.
    """
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        w = fh.write
        w("// GENERATED by tools/gen_protocol_ids.py -- do not edit.\n"
          "//\n"
          "// One assertion per observed protocol ID: that the packet named is a\n"
          "// type this build actually declares, and that its ID fits in the byte\n"
          "// it is written into.\n"
          "#include \"jx_protocol.h\"\n"
          "#include \"jx_protocol_ids.h\"\n\n"
          "#define JX_CHECK_ID(T, M)                                             \\\n"
          "    static_assert(sizeof(T) >= 1 && (M) >= 0 && (M) <= 255, #T)\n\n")
        n = 0
        for name in sorted(single):
            w(f"JX_CHECK_ID({name}, JX_ID({name}));\n")
            n += 1
        w("\n")
        for name in sorted(extended):
            w(f"JX_CHECK_ID({name}, JX_FAMILY({name}));\n")
            w(f"JX_CHECK_ID({name}, JX_SUBID({name}));\n")
            n += 2
    return n


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
         reworded: "list[tuple[int, str, str, int, int]]",
         send: "tuple[dict, dict, dict]") -> "tuple":
    live = {i: h for i, h in dispatch.items() if h != "0"}
    retired = sorted(i for i, h in dispatch.items() if h == "0")

    # Emit in the enum's own order, not sorted by value: several enumerators
    # share a value (c2s_clientbegin == c2s_login and so on), and reordering
    # would turn a boundary marker into the name of a real protocol.
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        w = fh.write
        w("// Protocol IDs. GENERATED -- do not edit.\n"
          "//\n"
          "//   python3 tools/gen_protocol_ids.py protocol/ -o src/protocol/\n"
          "//\n"
          "// Client to server, read out of the shipped binary two independent\n"
          "// ways: the c2s_PROTOCOL enum in its DWARF, and the ProcessFunc[]\n"
          "// table its KProtocolProcess constructor fills, which is what\n"
          "// ProcessNetMsg indexes with the first byte of the message. The\n"
          "// Windows KProtocolDef.h is a different version of the game and\n"
          "// disagrees about 31 of these; it was not used.\n"
          "//\n"
          "// The other direction has no enum to recover and is further down,\n"
          "// as macros. See docs/PHASE1.md.\n"
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

        return emit_send(fh, *send)


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

    # --- the other direction: IDs observed being written, with no enum -------
    packets = read_packet_names(os.path.join(args.tables, "binary_packets.tsv"))
    vals, where = read_send_ids(os.path.join(args.tables, "send_ids.tsv"))

    os.makedirs(args.out, exist_ok=True)
    out = os.path.join(args.out, "jx_protocol_ids.h")
    single, extended, ambiguous = emit(out, enum, dispatch, reworded,
                                       (vals, where, packets))

    checks = os.path.join(args.out, "jx_protocol_ids.cpp")
    nchecks = emit_send_checks(checks, single, extended)

    unknown = [n for n in vals if n not in packets]
    print("\nsend-side IDs, observed in the code:")
    print(f"  packet names with one ID           {len(single):4}")
    print(f"  ... EXTEND_HEADER family + ID      {len(extended):4}")
    print(f"  written with several IDs           {len(ambiguous):4}")
    print(f"  name not in the packet table       {len(unknown):4}"
          f"  {', '.join(sorted(unknown))}")
    print(f"  of {len(set(packets.values()))} packet structs, "
          f"{len({packets[n] for n in single} | {packets[n] for n in extended})}"
          f" have an observed ID")

    print(f"\nwrote {out}")
    print(f"wrote {checks}: {nchecks} assertions")
    return 0


if __name__ == "__main__":
    sys.exit(main())
