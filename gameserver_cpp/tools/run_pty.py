# Runs a command under a pty for a fixed number of seconds, teeing its output.
#
#     python3 tools/run_pty.py <seconds> <logfile> <command> [args ...]
#
# jx_gameserver is i386 and stdbuf works by LD_PRELOAD, so the preload object is
# the wrong architecture and the usual way to unbuffer it silently does nothing:
# a run ended by `timeout` loses its whole startup banner to libc's block buffer
# and looks like a server that printed nothing at all. libc line-buffers when
# stdout is a terminal, so giving it a pty is what makes the output survive.
import os
import pty
import select
import sys
import time

seconds = float(sys.argv[1])
logpath = sys.argv[2]
argv = sys.argv[3:]

deadline = time.time() + seconds
pid, fd = pty.fork()
if pid == 0:
    os.execv(argv[0], argv)

with open(logpath, "wb") as out:
    while time.time() < deadline:
        if not select.select([fd], [], [], 0.5)[0]:
            continue
        try:
            data = os.read(fd, 65536)
        except OSError:      # the child exited and closed the pty
            break
        if not data:
            break
        out.write(data)
        out.flush()
        sys.stdout.buffer.write(data)
        sys.stdout.buffer.flush()

os.kill(pid, 9)
os.waitpid(pid, 0)
