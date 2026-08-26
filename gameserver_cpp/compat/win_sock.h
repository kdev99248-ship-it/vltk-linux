// Winsock shims over BSD sockets.
//
// SOCKET is an int here, not an unsigned handle, so the Win32 idiom
// `s == INVALID_SOCKET` and the POSIX idiom `s < 0` both work.
#ifndef JX_COMPAT_WIN_SOCK_H
#define JX_COMPAT_WIN_SOCK_H

#include <arpa/inet.h>
#include <errno.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#include "win_types.h"

typedef int SOCKET;

#define INVALID_SOCKET (-1)
#define SOCKET_ERROR   (-1)

// Winsock error names used in the tree, mapped onto errno values. WSAEWOULDBLOCK
// is the one that matters: the non-blocking accept/recv loops test for it.
#define WSAEWOULDBLOCK  EWOULDBLOCK
#define WSAEINPROGRESS  EINPROGRESS
#define WSAECONNRESET   ECONNRESET
#define WSAECONNABORTED ECONNABORTED
#define WSAENOTCONN     ENOTCONN
#define WSAETIMEDOUT    ETIMEDOUT

inline int closesocket(SOCKET s) { return ::close(s); }
inline int WSAGetLastError(void) { return errno; }
inline int WSAStartup(WORD, void*) { return 0; }
inline int WSACleanup(void) { return 0; }

// Win32 spells the non-blocking toggle this way; on Linux it is fcntl.
int ioctlsocket(SOCKET s, long cmd, unsigned long* argp);
#ifndef FIONBIO
#define FIONBIO 0x5421
#endif

#endif  // JX_COMPAT_WIN_SOCK_H
