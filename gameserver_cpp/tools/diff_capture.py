#!/usr/bin/env python3
"""Compare two oracle_proxy captures and locate the first divergence.

    python3 tools/diff_capture.py captures/old-login.jsonl captures/new-login.jsonl

Chunk boundaries are meaningless -- TCP is free to split a write differently on
two runs, so comparing record-by-record reports differences that are pure
artefact. Records are concatenated per (connection, direction) into a byte
stream and the streams are compared. That is the level the protocol lives at.

Exit status is 0 when every stream matches, 1 when any diverges, so this drops
straight into a test script.
"""
import argparse
import base64
import json
import sys
from collections import OrderedDict


def load(path):
    """-> (meta, OrderedDict[(conn, dir)] = bytes)"""
    meta = {}
    streams = OrderedDict()
    with open(path, "r", encoding="utf-8") as fh:
        for lineno, line in enumerate(fh, 1):
            line = line.strip()
            if not line:
                continue
            try:
                rec = json.loads(line)
            except json.JSONDecodeError as exc:
                sys.exit(f"{path}:{lineno}: bad JSON: {exc}")
            kind = rec.get("type")
            if kind == "meta":
                meta = rec
            elif kind == "data":
                key = (rec["conn"], rec["dir"])
                streams.setdefault(key, bytearray()).extend(
                    base64.b64decode(rec["b64"]))
    return meta, OrderedDict((k, bytes(v)) for k, v in streams.items())


def hexdump(data, base=0, indent="    "):
    out = []
    for off in range(0, len(data), 16):
        chunk = data[off:off + 16]
        hexpart = " ".join(f"{b:02x}" for b in chunk)
        txt = "".join(chr(b) if 32 <= b < 127 else "." for b in chunk)
        out.append(f"{indent}{base + off:06x}  {hexpart:<47}  {txt}")
    return "\n".join(out)


def first_diff(a, b):
    """Index of the first differing byte, or None when one is a prefix of the
    other and they are the same length."""
    for i in range(min(len(a), len(b))):
        if a[i] != b[i]:
            return i
    return None if len(a) == len(b) else min(len(a), len(b))


def report_stream(key, a, b, context, max_bytes):
    conn, direction = key
    label = f"conn {conn} {direction}"
    idx = first_diff(a, b)
    if idx is None:
        print(f"  MATCH  {label:16} {len(a)} bytes")
        return True

    if idx >= min(len(a), len(b)):
        print(f"  DIFF   {label:16} identical for {idx} bytes, then one stream ends")
        print(f"         old {len(a)} bytes, new {len(b)} bytes "
              f"({len(b) - len(a):+d})")
    else:
        print(f"  DIFF   {label:16} first difference at byte {idx} (0x{idx:x})")
        print(f"         old {len(a)} bytes, new {len(b)} bytes "
              f"({len(b) - len(a):+d})")
        print(f"         old[{idx}]=0x{a[idx]:02x}  new[{idx}]=0x{b[idx]:02x}")

    lo = max(0, idx - context)
    hi = min(max(len(a), len(b)), idx + max_bytes)
    print("         --- old ---")
    print(hexdump(a[lo:min(hi, len(a))], lo, indent="         "))
    print("         --- new ---")
    print(hexdump(b[lo:min(hi, len(b))], lo, indent="         "))
    return False


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("old", help="capture from the reference (shipped) server")
    ap.add_argument("new", help="capture from the port")
    ap.add_argument("-c", "--context", type=int, default=32,
                    help="bytes to show before the divergence (default 32)")
    ap.add_argument("-n", "--max-bytes", type=int, default=96,
                    help="bytes to show after it (default 96)")
    args = ap.parse_args()

    meta_a, streams_a = load(args.old)
    meta_b, streams_b = load(args.new)

    print(f"old  {args.old}")
    print(f"     {meta_a.get('label') or '(no label)'}  "
          f"target={meta_a.get('target', '?')}  {len(streams_a)} streams")
    print(f"new  {args.new}")
    print(f"     {meta_b.get('label') or '(no label)'}  "
          f"target={meta_b.get('target', '?')}  {len(streams_b)} streams")
    print()

    keys = list(streams_a)
    for k in streams_b:
        if k not in streams_a:
            keys.append(k)

    ok = True
    for key in keys:
        a = streams_a.get(key)
        b = streams_b.get(key)
        if a is None:
            print(f"  ONLY-NEW  conn {key[0]} {key[1]}  {len(b)} bytes")
            ok = False
        elif b is None:
            print(f"  ONLY-OLD  conn {key[0]} {key[1]}  {len(a)} bytes")
            ok = False
        elif not report_stream(key, a, b, args.context, args.max_bytes):
            ok = False

    print()
    if ok:
        print(f"IDENTICAL -- {len(keys)} streams match byte for byte")
        return 0
    print("DIVERGED")
    return 1


if __name__ == "__main__":
    sys.exit(main())
