# Accept-only TCP listeners standing in for the five outbound peers.
#
#     python3 tools/dumb_peers.py <drop_after_seconds|0> [port ...]
#
# This is the CHEAP stub and it is deliberately not enough on its own. It gets
# librainbow's ConnectTo to succeed, so CreateClientConnections runs to the end
# and the connection-create event fires -- but librainbow completes its own key
# handshake (KClientManager::InitializeKey) before it flushes anything the
# application queued, and this stub never speaks it. Against these listeners
# SendPackToServer returns 1 on every call and not one byte reaches the wire.
#
# Use it for the links a test does not care about, and tools/peer_stub.cpp --
# a real libheaven.so listener -- for the one it does.
#
# drop_after > 0 shuts a link down that many seconds after it is accepted, which
# is how the CClientConnection::OnConnectionClose path gets exercised. shutdown()
# rather than close(): closing an fd another thread is blocked in recv() on does
# not reliably wake it.
import socket
import sys
import threading

DROP_AFTER = float(sys.argv[1]) if len(sys.argv) > 1 else 0   # 0 = never


def serve(port):
    s = socket.socket()
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind(("127.0.0.1", port))
    s.listen(8)
    while True:
        c, _ = s.accept()
        print("stub %d: accepted" % port, flush=True)
        threading.Thread(target=drain, args=(c, port), daemon=True).start()


def drain(c, port):
    if DROP_AFTER:
        threading.Timer(DROP_AFTER, lambda: c.shutdown(socket.SHUT_RDWR)).start()
    try:
        while True:
            b = c.recv(65536)
            if not b:
                break
            print("stub %d: %d bytes %s" % (port, len(b), b[:24].hex()), flush=True)
    except OSError as e:
        print("stub %d: closed (%s)" % (port, e), flush=True)
    print("stub %d: peer gone" % port, flush=True)


PORTS = [int(x) for x in sys.argv[2:]] or [46001, 46002, 46003, 46004, 46005]
for p in PORTS:
    threading.Thread(target=serve, args=(p,), daemon=True).start()
threading.Event().wait()
