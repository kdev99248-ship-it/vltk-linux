#!/usr/bin/env python3
"""Emit the KSG cipher's key table as a C++ source file.

The wire cipher is a table lookup:

    v5 = g_uPublicKeys[(i + key) % uNumOfPubKeys] + 0x2E6D23C1;
    *dword ^= v5;

so the table IS the cipher. It lives at 0x82AB6A0 in the shipped binary with
uNumOfPubKeys = 5679 at 0x82B0F5C, and it is byte-identical to the copy already
in the repo at config/reference/heaven_table.bin -- which is the same table
libheaven.so uses, recovered when the relay was made to talk to paysys.

Committing the generated .cpp rather than loading the .bin at run time is
deliberate, and matches what the binary does: the table is initialised data in
.rodata, not a file the server opens. A server that had to find a data file to
decrypt its first packet would have a failure mode the original does not.

    python3 tools/gen_ksg_table.py ../config/reference/heaven_table.bin \
        -o src/net/ksg_table.cpp
"""
from __future__ import annotations

import argparse
import hashlib
import struct
import sys

# From the binary: uNumOfPubKeys @ 0x82B0F5C. The count is not derived from the
# file size -- it is asserted against it, so a truncated or padded table is an
# error here rather than a wrong keystream later.
NUM_KEYS = 5679

PER_LINE = 6


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("table", help="heaven_table.bin (22716 bytes)")
    ap.add_argument("-o", "--out", required=True, help="the .cpp to write")
    args = ap.parse_args()

    data = open(args.table, "rb").read()
    if len(data) != NUM_KEYS * 4:
        sys.exit(f"{args.table}: expected {NUM_KEYS * 4} bytes "
                 f"({NUM_KEYS} keys), got {len(data)}")

    keys = struct.unpack(f"<{NUM_KEYS}I", data)
    digest = hashlib.sha256(data).hexdigest()

    out = []
    out.append("// The KSG cipher key table. GENERATED -- do not edit.\n")
    out.append("//\n")
    # No trailing backslash: a '\' at the end of a // line splices the next one
    # and GCC reports it as -Wcomment.
    out.append("//   python3 tools/gen_ksg_table.py"
               " ../config/reference/heaven_table.bin\n")
    out.append("//       -o src/net/ksg_table.cpp\n")
    out.append("//\n")
    out.append(f"// {NUM_KEYS} keys, {len(data)} bytes, read little-endian from\n")
    out.append("// config/reference/heaven_table.bin, which is byte-identical to\n")
    out.append("// g_uPublicKeys @ 0x082AB6A0 in server1/jx_linux_y.\n")
    out.append(f"// sha256 {digest}\n")
    out.append("\n")
    out.append('#include "ksg.h"\n')
    out.append("\n")
    out.append(f"const unsigned int g_uNumOfPubKeys = {NUM_KEYS};\n")
    out.append("\n")
    out.append(f"const unsigned int g_uPublicKeys[{NUM_KEYS}] = {{\n")
    for i in range(0, NUM_KEYS, PER_LINE):
        row = ", ".join("0x%08Xu" % k for k in keys[i:i + PER_LINE])
        out.append(f"    /* {i:5d} */ {row},\n")
    out.append("};\n")

    with open(args.out, "w", newline="\n") as fp:
        fp.write("".join(out))

    print(f"wrote {args.out}: {NUM_KEYS} keys, sha256 {digest[:16]}...",
          file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
