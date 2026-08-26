#!/usr/bin/env python3
"""Build the port worklist: every Class::Method in jx_linux_y, marked PORT or RE.

PORT = a definition with that name exists in the Windows source tree, so the job
       is to move it to Linux and validate it.
RE   = nothing in the source has that name, so the job is to read the
       disassembly and write it.

The unit of work is the method, never the class -- KPlayer alone is 119 PORT
methods plus 133 RE methods, and treating it as one item hides that.

Usage:
    python3 tools/build_worklist.py <path-to-SwordOnline> [-o tools/symbols/worklist.tsv]
"""
import argparse
import collections
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
SYMBOLS = os.path.join(HERE, "symbols", "ida_funcs.tsv")

# Class::Method( -- the same shape we match in both the binary's demangled names
# and the source. Templates and operator overloads are skipped: they carry
# punctuation that makes a name-only match meaningless.
DEF_RE = re.compile(r"\b([A-Za-z_]\w*)::(~?[A-Za-z_]\w*)\s*\(")
SRC_EXT = (".cpp", ".h", ".hpp", ".cxx", ".inl")


def index_source(root):
    """Map Class::Method -> first source file that defines it."""
    found = {}
    for dirpath, _dirnames, filenames in os.walk(root):
        for fn in filenames:
            if not fn.endswith(SRC_EXT):
                continue
            path = os.path.join(dirpath, fn)
            try:
                # The tree is GBK-encoded Chinese comments; we only need the
                # ASCII identifiers, so decode permissively.
                with open(path, "r", encoding="utf-8", errors="replace") as fh:
                    text = fh.read()
            except OSError:
                continue
            rel = os.path.relpath(path, root).replace("\\", "/")
            for cls, meth in DEF_RE.findall(text):
                found.setdefault(f"{cls}::{meth}", rel)
    return found


def read_binary_methods(path):
    """Extract (class, method, size) from the demangled symbol table."""
    out = {}
    with open(path, "r", encoding="utf-8") as fh:
        next(fh)  # header
        for line in fh:
            parts = line.rstrip("\n").split("\t")
            if len(parts) != 4:
                continue
            _addr, size, _mangled, dem = parts
            name = dem.split("(")[0]
            if "::" not in name:
                continue
            bits = name.split("::")
            cls, meth = bits[-2], bits[-1]
            if not re.fullmatch(r"[A-Za-z_]\w*", cls):
                continue
            if not re.fullmatch(r"~?[A-Za-z_]\w*", meth):
                continue
            key = (cls, meth)
            out[key] = out.get(key, 0) + int(size)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("source_root", help="path to SwordOnline/")
    ap.add_argument("-o", "--out", default=os.path.join(HERE, "symbols", "worklist.tsv"))
    args = ap.parse_args()

    if not os.path.isdir(args.source_root):
        sys.exit(f"not a directory: {args.source_root}")

    binary = read_binary_methods(SYMBOLS)
    source = index_source(args.source_root)

    rows = []
    for (cls, meth), size in binary.items():
        key = f"{cls}::{meth}"
        src = source.get(key)
        rows.append((cls, meth, size, "PORT" if src else "RE", src or ""))

    # Heaviest classes first, then heaviest methods -- the order you work in.
    by_class = collections.Counter()
    for cls, _m, size, _s, _f in rows:
        by_class[cls] += size
    rows.sort(key=lambda r: (-by_class[r[0]], r[0], -r[2], r[1]))

    os.makedirs(os.path.dirname(args.out), exist_ok=True)
    with open(args.out, "w", encoding="utf-8", newline="\n") as fh:
        fh.write("class\tmethod\tcode_bytes\tstatus\tsource_file\n")
        for r in rows:
            fh.write("\t".join(str(x) for x in r) + "\n")

    port = [r for r in rows if r[3] == "PORT"]
    re_ = [r for r in rows if r[3] == "RE"]
    kb = lambda rs: sum(r[2] for r in rs) / 1024.0
    print(f"wrote {args.out}")
    print(f"  total {len(rows):5d} methods  {kb(rows):8.1f} KB")
    print(f"  PORT  {len(port):5d} methods  {kb(port):8.1f} KB  ({100*kb(port)/kb(rows):.0f}%)")
    print(f"  RE    {len(re_):5d} methods  {kb(re_):8.1f} KB  ({100*kb(re_)/kb(rows):.0f}%)")


if __name__ == "__main__":
    main()
