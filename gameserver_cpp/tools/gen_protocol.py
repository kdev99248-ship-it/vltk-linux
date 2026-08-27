#!/usr/bin/env python3
"""Generate the protocol header from the layouts read out of the shipped binary.

Phase 0 established that the Windows protocol headers cannot be ported: for the
structs both trees define they are wrong 44% of the time, and they are missing
236 packets this server actually uses. The layouts extracted from the binary's
own DWARF are correct by construction, so the protocol layer is generated from
those instead of adapted from `KProtocol.h`.

Two files come out:

    src/protocol/jx_protocol.h    the declarations
    src/protocol/jx_layout.cpp    a static_assert for every size and offset

The split matters. Two thousand static_asserts in a header would be re-checked
by every translation unit that includes it; in their own file they are checked
once, and that file failing to compile is exactly the signal wanted.

Everything is emitted `#pragma pack(1)` with padding written out explicitly
wherever the binary shows a gap, rather than declared with natural alignment and
left to the compiler. Two structs need it -- `_tagSyncFileHead` has two bytes of
internal padding and `VIEW_OTHER_DETAIL_INFO` one byte of trailing padding,
because on i386 a `long long` member gives a struct 4-byte alignment. Spelling
the padding out means the layout does not depend on the compiler agreeing with
GCC 3.x about alignment rules, and the asserts prove it byte for byte.

Usage:
    python3 tools/gen_protocol.py protocol/ -o src/protocol/
"""
import argparse
import os
import re
import sys
from collections import OrderedDict

# Sizes every layout below silently assumes. Asserted in the generated header so
# a toolchain that disagrees -- a 64-bit build, or a 32-bit one with 64-bit
# time_t -- fails loudly instead of shifting every field after the first INT64.
PRIMITIVES = OrderedDict((
    ("BYTE", 1), ("CHAR", 1), ("char", 1), ("bool", 1), ("unsigned char", 1),
    ("WORD", 2), ("short int", 2), ("short unsigned int", 2),
    ("DWORD", 4), ("UINT", 4), ("INT", 4), ("BOOL", 4), ("int", 4),
    ("unsigned int", 4), ("long unsigned int", 4), ("size_t", 4),
    ("time_t", 4), ("LPVOID", 4),
    ("INT64", 8), ("int64_t", 8),
))

# Defined by compat/win_types.h already; re-declaring them would be a redefinition
# and, worse, a second opinion about a layout that is already pinned there.
PROVIDED = {"GUID", "_GUID"}

ARRAY_RE = re.compile(r"^(.*?)((?:\[\d*\])+)$")


class Decl:
    __slots__ = ("name", "alias", "base", "kind", "size", "fields", "bases")

    def __init__(self, name, alias, base, kind, size):
        self.name = name
        self.alias = alias
        self.base = base            # protocol header base, "" for plain types
        self.kind = kind            # struct | union | class
        self.size = size
        self.fields = []            # (name, offset|None, type, size|None)
        self.bases = []             # inherited-from type names, in order


def split_array(ty):
    """`char[32]` -> ("char", "[32]"); `BYTE[]` -> ("BYTE", "[]")."""
    m = ARRAY_RE.match(ty)
    if m:
        return m.group(1), m.group(2)
    return (ty[:-2], "[]") if ty.endswith("[]") else (ty, "")


def load(path):
    """Read one layout TSV into {name: Decl}, preserving field order."""
    out = OrderedDict()
    with open(path, "r", encoding="utf-8") as fh:
        header = next(fh).rstrip("\n").split("\t")
        if header[:4] != ["struct", "alias", "base", "kind"]:
            sys.exit(f"{path}: unexpected columns {header} -- regenerate it with "
                     "tools/dwarf_structs.py --packets/--types")
        for line in fh:
            r = line.rstrip("\n").split("\t")
            name, alias, base, kind, size, off, fname, ty, fsz = r[:9]
            d = out.get(name)
            if d is None:
                d = out[name] = Decl(name, alias, base, kind, int(size))
            if fname == "(base)":
                d.bases.append(ty)
            d.fields.append((fname, int(off) if off else None, ty,
                             int(fsz) if fsz else None))
    return out


def load_enums(path):
    out = OrderedDict()
    with open(path, "r", encoding="utf-8") as fh:
        next(fh)
        for line in fh:
            name, size, ename, val = line.rstrip("\n").split("\t")
            out.setdefault(name, (int(size), []))[1].append((ename, int(val)))
    return out


def order(decls):
    """Topological sort: a type is declared after everything it embeds.

    Ties break on name so the output is stable across runs -- a generated file
    that reshuffles itself is unreviewable in a diff.
    """
    deps = {}
    for name, d in decls.items():
        need = set(d.bases)
        for _fname, _off, ty, _fsz in d.fields:
            elem, _arr = split_array(ty)
            if elem in decls:
                need.add(elem)
        deps[name] = {n for n in need if n in decls and n != name}

    out, done = [], set()
    pending = sorted(decls)
    while pending:
        ready = [n for n in pending if deps[n] <= done]
        if not ready:
            # Only a cycle can cause this, and a cycle among by-value members is
            # impossible in C++ -- so it means the extraction is wrong, not that
            # the emitter needs to be cleverer.
            sys.exit("cyclic type dependency among: " + ", ".join(sorted(pending)))
        for n in ready:
            out.append(n)
            done.add(n)
        pending = [n for n in pending if n not in done]
    return out


def emit_struct(d, decls, inlined, out):
    """Write one struct, padding included, to the list of lines `out`."""
    head = f"struct {d.name}"
    if d.bases:
        head += " : " + ", ".join(d.bases)
    out.append(head + " {")

    # Bases occupy the front of the object; members are placed after them.
    cur = 0
    for fname, off, ty, fsz in d.fields:
        if fname == "(base)":
            cur = (off or 0) + (fsz or 0)
            continue

        if off is not None and off > cur:
            out.append(f"    BYTE _jxpad_{cur}[{off - cur}];"
                       f"   // padding the binary shows here")
            cur = off

        elem, arr = split_array(ty)
        if not fname:
            # An unnamed member of an anonymous aggregate -- C's anonymous union
            # idiom, which is how tagProtocolHeader carries both `cProtocol` and
            # `ProtocolType` as names for the same byte.
            sub = decls[elem]
            out.append(f"    {sub.kind} {{")
            for sname, _so, sty, _ss in sub.fields:
                selem, sarr = split_array(sty)
                out.append(f"        {selem} {sname}{sarr};")
            out.append("    };")
            inlined.add(elem)
        else:
            out.append(f"    {elem} {fname}{arr};")

        if fsz is None:
            cur = off if off is not None else cur   # flexible tail, adds nothing
        elif off is not None:
            cur = off + fsz

    if cur < d.size:
        out.append(f"    BYTE _jxpad_{cur}[{d.size - cur}];"
                   f"   // trailing padding: this struct is not pack(1) upstream")
    out.append("};")
    if d.alias and d.alias != d.name:
        out.append(f"typedef {d.name} {d.alias};")
    out.append("")


def emit_header(decls, names, enums, path):
    L = ["// GENERATED by tools/gen_protocol.py -- do not edit.",
         "//",
         "// Layouts read out of server1/jx_linux_y's DWARF, not ported from the",
         "// Windows headers, which are wrong for 44% of the structs both trees",
         "// define and missing 236 of the packets this server sends.",
         "//",
         f"// {len(names)} types, {sum(len(decls[n].fields) for n in names)} fields.",
         "// Sizes and offsets are asserted in src/protocol/jx_layout.cpp.",
         "",
         "#ifndef JX_PROTOCOL_H",
         "#define JX_PROTOCOL_H",
         "",
         "#include <cstddef>",
         "#include <cstdint>",
         "#include <ctime>",
         "",
         "#include <windows.h>   // compat/: BYTE, WORD, DWORD, GUID, ...",
         "",
         "#ifndef JX_INT64_DEFINED",
         "#define JX_INT64_DEFINED",
         "typedef int64_t INT64;",
         "#endif",
         "",
         "// Every layout below assumes these. On a toolchain where one differs --",
         "// a 64-bit build, or a 32-bit one with _TIME_BITS=64 -- the packets do",
         "// not merely change size, they desynchronise the client. Fail here.",
         ]
    for ty, size in PRIMITIVES.items():
        L.append(f'static_assert(sizeof({ty}) == {size}, "{ty} must be '
                 f'{size} byte{"s" if size > 1 else ""} on the wire");')
    L += ["", ]

    if enums:
        L.append("// ---- enums a packet field refers to " + "-" * 39)
        L.append("")
        for name, (size, vals) in enums.items():
            L.append(f"enum {name} {{")
            for ename, val in vals:
                L.append(f"    {ename} = {val},")
            L.append("};")
            L.append(f'static_assert(sizeof({name}) == {size}, "{name}");')
            L.append("")

    L += ["// ---- packets and the types they embed " + "-" * 37,
          "//",
          "// pack(1) with padding written out explicitly wherever the binary",
          "// shows a gap, so the layout does not depend on this compiler",
          "// agreeing with the original about alignment.",
          "",
          "#pragma pack(push, 1)",
          ""]

    inlined = set()
    body = []
    for n in names:
        emit_struct(decls[n], decls, inlined, body)
    L += body
    L += ["#pragma pack(pop)", "", "#endif  // JX_PROTOCOL_H", ""]

    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write("\n".join(L))
    return inlined


def emit_checks(decls, names, path, header):
    """One static_assert per size and per member offset.

    This is the file that makes the generator trustworthy. The header is a claim
    about 413 layouts; this is the compiler checking every one of them against
    the numbers the shipped binary reported.
    """
    L = ["// GENERATED by tools/gen_protocol.py -- do not edit.",
         "//",
         "// Every size and every member offset in the generated header, checked",
         "// against what server1/jx_linux_y's DWARF reported. If this file does",
         "// not compile, the port and the shipped server disagree about the wire",
         "// format, and the disagreement is named in the failing line.",
         "",
         "#include <cstddef>",
         "",
         f'#include "{header}"',
         "",
         "// offsetof on a type with a base class is conditionally-supported;",
         "// GCC computes it correctly for these, which are all standard-layout",
         "// but for the header base they inherit.",
         '#pragma GCC diagnostic ignored "-Winvalid-offsetof"',
         ""]
    nsize = noff = 0
    for n in names:
        d = decls[n]
        L.append(f'static_assert(sizeof({n}) == {d.size}, "sizeof({n})");')
        nsize += 1
        for fname, off, _ty, _fsz in d.fields:
            if not fname or fname == "(base)" or off is None:
                continue
            L.append(f"static_assert(offsetof({n}, {fname}) == {off}, "
                     f'"{n}.{fname}");')
            noff += 1
        L.append("")
    with open(path, "w", encoding="utf-8", newline="\n") as fh:
        fh.write("\n".join(L))
    return nsize, noff


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("tables", help="directory holding the binary_*.tsv tables")
    ap.add_argument("-o", "--out", default="src/protocol",
                    help="directory to write jx_protocol.h and jx_layout.cpp")
    args = ap.parse_args()

    packets = load(os.path.join(args.tables, "binary_packets.tsv"))
    types = load(os.path.join(args.tables, "binary_types.tsv"))
    enums = load_enums(os.path.join(args.tables, "binary_enums.tsv"))

    decls = OrderedDict()
    for src in (types, packets):
        for name, d in src.items():
            if name in PROVIDED:
                continue
            if name in decls:
                sys.exit(f"{name} is declared in both tables -- ambiguous")
            decls[name] = d

    missing = set()
    for d in decls.values():
        for _f, _o, ty, _s in d.fields:
            elem, _a = split_array(ty)
            if elem not in decls and elem not in PRIMITIVES \
                    and elem not in enums and elem not in PROVIDED:
                missing.add(elem)
    if missing:
        sys.exit("unresolved types (regenerate the tables with --types): "
                 + ", ".join(sorted(missing)))

    names = order(decls)
    os.makedirs(args.out, exist_ok=True)
    hpath = os.path.join(args.out, "jx_protocol.h")
    cpath = os.path.join(args.out, "jx_layout.cpp")

    inlined = emit_header(decls, names, enums, hpath)
    # A union reached only through an unnamed member has no independent
    # existence: it was emitted inline at its use site, so it must not also be
    # asserted as a standalone type that no longer exists.
    checked = [n for n in names if n not in inlined]
    nsize, noff = emit_checks(decls, checked, cpath, "jx_protocol.h")

    npackets = sum(1 for n in names if decls[n].base)
    print(f"wrote {hpath}")
    print(f"  {npackets} packets + {len(names) - npackets} embedded types"
          f" + {len(enums)} enums")
    print(f"  {len(inlined)} anonymous unions inlined at their use site")
    print(f"wrote {cpath}")
    print(f"  {nsize} size assertions, {noff} offset assertions")


if __name__ == "__main__":
    main()
