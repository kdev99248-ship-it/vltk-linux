#!/usr/bin/env python3
"""Verify the ported KSG cipher against the independent Python implementation.

The C++ half (tools/ksg_vectors.cpp, built in the container) prints one line per
vector:

    <size> <key-hex8> <plaintext-hex> <ciphertext-hex>

This recomputes each ciphertext with oracle_proxy.ksg_decode -- a separate
implementation, ported from the s3relay server and verified byte-exact against
live bishop_y traffic -- and diffs. Two implementations derived from different
binaries agreeing on every vector is the evidence; either one alone is a claim.

    python3 tools/check_ksg.py vectors.txt

Exits non-zero on any mismatch, so it can be a build gate.
"""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import oracle_proxy  # noqa: E402

# heaven_table.bin lives with the deployment config, not in this tree -- same
# candidates test_oracle.py uses.
TABLE_CANDIDATES = [
    os.path.join(REPO, "..", "config", "reference", "heaven_table.bin"),
    os.path.join(REPO, "reference", "heaven_table.bin"),
]


def find_table():
    for path in TABLE_CANDIDATES:
        if os.path.exists(path):
            return path
    sys.exit("heaven_table.bin not found; looked in:\n  " +
             "\n  ".join(os.path.abspath(p) for p in TABLE_CANDIDATES))


def main():
    if len(sys.argv) != 2:
        sys.exit(f"usage: {sys.argv[0]} <vectors.txt>")

    table_path = find_table()
    table = oracle_proxy.load_ksg_table(table_path)
    print(f"table   {table_path} ({len(table)} keys)")

    with open(sys.argv[1], "r", encoding="ascii") as fh:
        lines = [ln.strip() for ln in fh if ln.strip()]

    if not lines:
        sys.exit("no vectors in input")

    bad = 0
    for lineno, line in enumerate(lines, 1):
        parts = line.split()
        if len(parts) != 4:
            sys.exit(f"line {lineno}: expected 4 fields, got {len(parts)}")

        size = int(parts[0])
        key = int(parts[1], 16)
        # "-" is the empty buffer; bytes.fromhex("") would also work but "-"
        # keeps the field count fixed at four.
        plain = b"" if parts[2] == "-" else bytes.fromhex(parts[2])
        cipher = b"" if parts[3] == "-" else bytes.fromhex(parts[3])

        if len(plain) != size or len(cipher) != size:
            sys.exit(f"line {lineno}: size {size} but {len(plain)}/{len(cipher)} bytes")

        want = oracle_proxy.ksg_decode(table, plain, key)
        if want != cipher:
            bad += 1
            if bad <= 5:
                print(f"  MISMATCH size={size} key={key:08x}")
                print(f"    python {want.hex()}")
                print(f"    c++    {cipher.hex()}")

    print(f"vectors {len(lines)}")
    if bad:
        print(f"FAIL    {bad} mismatched")
        return 1

    print("ok      every vector agrees with tools/oracle_proxy.py")
    return 0


if __name__ == "__main__":
    sys.exit(main())
