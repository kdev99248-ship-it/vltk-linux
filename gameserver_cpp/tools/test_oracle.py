#!/usr/bin/env python3
"""Self-test for oracle_proxy.py and diff_capture.py.

The oracle is the thing that decides whether the port is correct, so it has to
be right before it is trusted. This stands up a fake server on loopback, proxies
a real TCP session through it, and checks the capture and the differ against
known answers.

    python3 tools/test_oracle.py

Needs no server, no network and no toolchain -- it is deliberately runnable on a
bare Python install, which is all the dev host has.
"""
import base64
import json
import os
import socket
import subprocess
import sys
import tempfile
import threading
import time

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import oracle_proxy  # noqa: E402

# heaven_table.bin lives with the deployment config, not in this tree.
TABLE_CANDIDATES = [
    os.path.join(REPO, "..", "config", "reference", "heaven_table.bin"),
    os.path.join(REPO, "reference", "heaven_table.bin"),
]

failures = []


def check(cond, msg):
    if cond:
        print(f"  ok    {msg}")
    else:
        print(f"  FAIL  {msg}")
        failures.append(msg)


def fake_server(port, reply, ready):
    srv = socket.socket()
    srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    srv.bind(("127.0.0.1", port))
    srv.listen(4)
    ready.set()
    conn, _ = srv.accept()
    conn.recv(4096)
    conn.sendall(reply)
    time.sleep(0.2)
    conn.close()
    srv.close()


def session(sport, pport, reply, out, label):
    """Run one client<->proxy<->server exchange; return what the client got."""
    ready = threading.Event()
    threading.Thread(target=fake_server, args=(sport, reply, ready),
                     daemon=True).start()
    ready.wait(5)
    proxy = subprocess.Popen(
        [sys.executable, os.path.join(HERE, "oracle_proxy.py"),
         "--listen", f"127.0.0.1:{pport}", "--target", f"127.0.0.1:{sport}",
         "--out", out, "--label", label],
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    time.sleep(1.5)
    cli = socket.create_connection(("127.0.0.1", pport), timeout=5)
    cli.sendall(b"LOGIN\x01\x02\x03hello world")
    got = cli.recv(4096)
    cli.close()
    time.sleep(0.5)
    proxy.terminate()
    try:
        proxy.communicate(timeout=5)
    except subprocess.TimeoutExpired:
        proxy.kill()
        proxy.communicate()
    return got


def run_diff(a, b):
    p = subprocess.run([sys.executable, os.path.join(HERE, "diff_capture.py"), a, b],
                       capture_output=True, text=True)
    return p.returncode, p.stdout


def main():
    tmp = tempfile.mkdtemp(prefix="jx-oracle-")
    old = os.path.join(tmp, "old.jsonl")
    same = os.path.join(tmp, "same.jsonl")
    new = os.path.join(tmp, "new.jsonl")

    print("1. proxy forwards traffic and records both directions")
    got = session(19001, 19101, b"WELCOME\xff\x00\xfe", old, "reference")
    check(got == b"WELCOME\xff\x00\xfe", f"client received the reply intact ({got!r})")
    recs = [json.loads(l) for l in open(old, encoding="utf-8") if l.strip()]
    data = [r for r in recs if r["type"] == "data"]
    check(recs and recs[0]["type"] == "meta" and recs[0]["label"] == "reference",
          "capture opens with a meta record carrying the label")
    c2s = [r for r in data if r["dir"] == "c2s"]
    s2c = [r for r in data if r["dir"] == "s2c"]
    check(any(base64.b64decode(r["b64"]) == b"LOGIN\x01\x02\x03hello world"
              for r in c2s), "c2s payload byte-exact")
    # \xff\x00\xfe is the point: a text-mode or NUL-truncating sink loses this.
    check(any(base64.b64decode(r["b64"]) == b"WELCOME\xff\x00\xfe" for r in s2c),
          "s2c payload byte-exact through NUL and high bytes")

    print("2. two identical sessions compare equal")
    session(19002, 19102, b"WELCOME\xff\x00\xfe", same, "port")
    rc, out = run_diff(old, same)
    check(rc == 0, "differ exits 0")
    check("IDENTICAL" in out, "differ reports IDENTICAL")

    print("3. a one-byte change is located exactly")
    session(19003, 19103, b"WELCOME\xff\x01\xfe", new, "port")
    rc, out = run_diff(old, new)
    check(rc == 1, "differ exits 1")
    check("first difference at byte 8" in out, "offset 8 reported")
    check("old[8]=0x00" in out and "new[8]=0x01" in out, "both bytes reported")
    check("MATCH  conn 1 c2s" in out, "the unchanged direction still matches")

    print("4. KSG codec")
    table_path = next((p for p in TABLE_CANDIDATES if os.path.isfile(p)), None)
    if not table_path:
        print("  skip  heaven_table.bin not found; codec untested")
    else:
        size = os.path.getsize(table_path)
        table = oracle_proxy.load_ksg_table(table_path)
        check(size == 22716 and len(table) == 5679,
              f"table is 22716 bytes / 5679 entries (got {size}/{len(table)})")
        bad = []
        for key in (0, 0x12345678, 0xFFFFFFFF, 0xDEADBEEF):
            for n in (0, 1, 2, 3, 4, 5, 7, 8, 15, 16, 17, 33, 64, 512, 1461):
                plain = bytes((i * 7 + n) & 0xFF for i in range(n))
                if oracle_proxy.ksg_decode(
                        table, oracle_proxy.ksg_decode(table, plain, key),
                        key) != plain:
                    bad.append((key, n))
        check(not bad, f"60 round-trips exact, tails of 1-3 bytes included ({bad})")
        # Regression pin. If this changes, the codec drifted from the C++ in
        # s3relayserver_cpp that was verified byte-exact against live bishop_y.
        got_hex = oracle_proxy.ksg_decode(table, bytes(range(16)), 0x12345678).hex()
        check(got_hex == "1ca9f419b6441ddef90f0f384d205f01",
              f"known-answer vector matches ({got_hex})")
        # table[1] is 0x3393f600 -- low byte zero -- so a 1-byte payload under
        # key 0 legitimately XORs with 0. Documented so it is not mistaken for
        # a bug when someone hits it.
        check(oracle_proxy.ksg_decode(table, b"\x41", 0) == b"\x41",
              "known degenerate case (key 0, 1 byte) is a no-op, as in the C++")

    print()
    if failures:
        print(f"FAILED: {len(failures)} check(s)")
        for f in failures:
            print(f"  - {f}")
        return 1
    print("ALL CHECKS PASSED")
    return 0


if __name__ == "__main__":
    sys.exit(main())
