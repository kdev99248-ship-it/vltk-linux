#!/usr/bin/env python3
"""TCP capture proxy -- the oracle half of Phase 0.

The port has one authority on correct behaviour: the shipped binary. Sitting
between a client and the old server records exactly what it says; pointing the
same client at the new build and recording again turns "does the port work?"
into a byte diff (tools/diff_capture.py).

Captures are JSONL, one record per read, payload base64-encoded. Base64 rather
than hex because these files get long and it halves them; JSONL rather than pcap
because it needs no tooling to read and diffs cleanly.

    python3 tools/oracle_proxy.py --listen 0.0.0.0:5560 --target 10.211.55.2:5560 \
        --out captures/old-login.jsonl

Then point the client at the proxy instead of the server. Run it once against
the old server and once against the new one, with the same client actions.

Decoding: --ksg-table reference/heaven_table.bin adds a decoded view to the hex
tail. It does NOT alter what is captured -- the capture is always the bytes on
the wire, so a decode bug cannot corrupt the evidence.
"""
import argparse
import base64
import binascii
import json
import os
import selectors
import socket
import struct
import sys
import threading
import time

KSG_ADD = 0x2E6D23C1


def load_ksg_table(path):
    """heaven_table.bin: 5679 little-endian uint32. Exactly 22716 bytes."""
    with open(path, "rb") as fh:
        raw = fh.read()
    if len(raw) % 4 or not raw:
        raise ValueError(f"{path}: {len(raw)} bytes is not a whole number of u32")
    return list(struct.unpack(f"<{len(raw) // 4}I", raw))


def ksg_decode(table, data, key):
    """The chained table keystream from KSG_EncodeDecode.cpp.

    Ported from the C++ in s3relayserver_cpp/src/main.cpp, which was verified
    byte-exact against live bishop_y output. XOR is symmetric: same function
    encodes and decodes. The key is consumed by value -- each frame restarts
    from the connection key, it does not advance across frames.
    """
    if not table:
        return bytes(data)
    modulus = len(table)
    out = bytearray(data)
    num_words = len(out) >> 2
    rem = len(out) & 3
    esi = key & 0xFFFFFFFF
    for i in range(num_words):
        counter = num_words - 1 - i
        # The & 0xFFFFFFFF on the sum is load-bearing and easy to lose in a
        # Python transcription: the i386 original is `lea eax, [ebx+esi]`
        # followed by `div`, so the addition wraps at 2**32 before the modulo.
        # Python ints do not wrap, and without the mask this diverges from the
        # binary whenever esi + counter overflows -- rare enough with real keys
        # that live traffic never showed it, and immediate with a key near
        # 0xFFFFFFFF. Caught by tools/check_ksg.py.
        esi = (table[((counter + esi) & 0xFFFFFFFF) % modulus] + KSG_ADD) & 0xFFFFFFFF
        off = i * 4
        word = int.from_bytes(out[off:off + 4], "little") ^ esi
        out[off:off + 4] = word.to_bytes(4, "little")
    if rem:
        tmp = table[rem % modulus] ^ esi
        for j in range(rem):
            out[num_words * 4 + j] ^= (tmp >> (8 * j)) & 0xFF
    return bytes(out)


def hexdump(data, limit=64, indent="    "):
    out = []
    view = data[:limit]
    for off in range(0, len(view), 16):
        chunk = view[off:off + 16]
        hexpart = " ".join(f"{b:02x}" for b in chunk)
        txt = "".join(chr(b) if 32 <= b < 127 else "." for b in chunk)
        out.append(f"{indent}{off:04x}  {hexpart:<47}  {txt}")
    if len(data) > limit:
        out.append(f"{indent}... {len(data) - limit} more bytes")
    return "\n".join(out)


class Capture:
    """Append-only JSONL sink. One lock: several connections share one file so
    records stay in true chronological order across the whole session."""

    def __init__(self, path):
        os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
        self._fh = open(path, "w", encoding="utf-8", newline="\n")
        self._lock = threading.Lock()
        self._t0 = time.monotonic()
        self.count = 0
        self.bytes = 0

    def meta(self, **kw):
        self._write({"type": "meta", **kw})

    def record(self, conn_id, direction, payload):
        self._write({
            "type": "data",
            "conn": conn_id,
            "dir": direction,                      # c2s | s2c
            "t": round(time.monotonic() - self._t0, 6),
            "len": len(payload),
            "crc": f"{binascii.crc32(payload):08x}",
            "b64": base64.b64encode(payload).decode("ascii"),
        })
        self.count += 1
        self.bytes += len(payload)

    def event(self, conn_id, what, detail=""):
        self._write({
            "type": "event",
            "conn": conn_id,
            "t": round(time.monotonic() - self._t0, 6),
            "what": what,
            "detail": detail,
        })

    def _write(self, obj):
        line = json.dumps(obj, separators=(",", ":"))
        with self._lock:
            self._fh.write(line + "\n")
            self._fh.flush()   # a crash mid-session must not lose the evidence

    def close(self):
        with self._lock:
            self._fh.close()


class Proxy:
    def __init__(self, listen, target, capture, args):
        self.listen = listen
        self.target = target
        self.cap = capture
        self.args = args
        self.table = None
        if args.ksg_table:
            self.table = load_ksg_table(args.ksg_table)
            print(f"ksg table: {len(self.table)} entries from {args.ksg_table}")
        self._next_id = 0
        self._id_lock = threading.Lock()

    def _alloc_id(self):
        with self._id_lock:
            self._next_id += 1
            return self._next_id

    def serve(self):
        srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        srv.bind(self.listen)
        srv.listen(64)
        print(f"listening on {self.listen[0]}:{self.listen[1]} "
              f"-> {self.target[0]}:{self.target[1]}")
        print(f"capture: {self.args.out}")
        try:
            while True:
                client, addr = srv.accept()
                cid = self._alloc_id()
                threading.Thread(target=self._handle, args=(client, addr, cid),
                                 daemon=True).start()
        except KeyboardInterrupt:
            print("\nstopping")
        finally:
            srv.close()

    def _handle(self, client, addr, cid):
        peer = f"{addr[0]}:{addr[1]}"
        self.cap.event(cid, "accept", peer)
        print(f"[{cid}] accept {peer}")
        upstream = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            upstream.connect(self.target)
        except OSError as exc:
            self.cap.event(cid, "connect-failed", str(exc))
            print(f"[{cid}] upstream connect failed: {exc}")
            client.close()
            return

        # Nagle would coalesce writes and change the chunk boundaries between
        # the two runs being compared, producing diffs that are pure artefact.
        for sock in (client, upstream):
            sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)

        sel = selectors.DefaultSelector()
        sel.register(client, selectors.EVENT_READ, ("c2s", client, upstream))
        sel.register(upstream, selectors.EVENT_READ, ("s2c", upstream, client))
        try:
            while True:
                for key, _mask in sel.select(timeout=1.0):
                    direction, src, dst = key.data
                    try:
                        buf = src.recv(65536)
                    except OSError as exc:
                        self.cap.event(cid, "recv-error", f"{direction}: {exc}")
                        return
                    if not buf:
                        self.cap.event(cid, "eof", direction)
                        print(f"[{cid}] eof {direction}")
                        return
                    self.cap.record(cid, direction, buf)
                    if self.args.verbose:
                        self._show(cid, direction, buf)
                    try:
                        dst.sendall(buf)
                    except OSError as exc:
                        self.cap.event(cid, "send-error", f"{direction}: {exc}")
                        return
        finally:
            sel.close()
            client.close()
            upstream.close()
            self.cap.event(cid, "close")
            print(f"[{cid}] closed  ({self.cap.count} records, "
                  f"{self.cap.bytes} bytes captured)")

    def _show(self, cid, direction, buf):
        arrow = "-->" if direction == "c2s" else "<--"
        print(f"[{cid}] {arrow} {len(buf)} bytes")
        print(hexdump(buf, self.args.hex_limit))
        if self.table is not None:
            dec = ksg_decode(self.table, buf, self.args.ksg_key)
            print(f"    -- ksg key=0x{self.args.ksg_key:08x} --")
            print(hexdump(dec, self.args.hex_limit))


def hostport(text):
    if ":" not in text:
        raise argparse.ArgumentTypeError(f"expected host:port, got {text!r}")
    host, _, port = text.rpartition(":")
    return (host, int(port))


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--listen", type=hostport, default=("0.0.0.0", 5560))
    ap.add_argument("--target", type=hostport, required=True,
                    help="the real server, host:port")
    ap.add_argument("--out", required=True, help="capture file (JSONL)")
    ap.add_argument("--label", default="", help="recorded in the capture header")
    ap.add_argument("-v", "--verbose", action="store_true",
                    help="hex dump every chunk to stdout")
    ap.add_argument("--hex-limit", type=int, default=64,
                    help="bytes per dump when verbose (default 64, 0 = all)")
    ap.add_argument("--ksg-table", help="heaven_table.bin, enables a decoded view")
    ap.add_argument("--ksg-key", type=lambda s: int(s, 0), default=0,
                    help="per-connection KSG key (default 0)")
    args = ap.parse_args()
    if args.hex_limit == 0:
        args.hex_limit = 1 << 30

    cap = Capture(args.out)
    cap.meta(
        label=args.label,
        listen=f"{args.listen[0]}:{args.listen[1]}",
        target=f"{args.target[0]}:{args.target[1]}",
        started=time.strftime("%Y-%m-%dT%H:%M:%S"),
        tool="oracle_proxy.py",
    )
    try:
        Proxy(args.listen, args.target, cap, args).serve()
    finally:
        cap.close()
        print(f"wrote {args.out}: {cap.count} records, {cap.bytes} bytes")
    return 0


if __name__ == "__main__":
    sys.exit(main())
