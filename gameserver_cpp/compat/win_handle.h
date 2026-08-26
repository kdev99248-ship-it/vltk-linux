// HANDLE: one opaque type covering both of the kernel objects the JX sources
// actually create -- events and threads.
//
// Win32 lets CloseHandle and WaitForSingleObject act on either, so the handle
// carries a kind tag and both calls dispatch on it. Files are NOT handles here:
// the tree opens files through the CRT (fopen/open), and the three WriteFile
// call sites are in Windows-only code that does not get ported.
#ifndef JX_COMPAT_WIN_HANDLE_H
#define JX_COMPAT_WIN_HANDLE_H

#include <pthread.h>

#include "win_types.h"

enum KHandleKind {
    KHANDLE_EVENT,
    KHANDLE_THREAD,
};

struct KHandleObject {
    KHandleKind kind;

    // KHANDLE_EVENT
    pthread_mutex_t mutex;
    pthread_cond_t  cond;
    bool            signaled;
    bool            manual_reset;

    // KHANDLE_THREAD
    pthread_t       thread;
    bool            detached;
};

typedef KHandleObject* HANDLE;

#define INVALID_HANDLE_VALUE (reinterpret_cast<HANDLE>(-1))

// WaitForSingleObject return codes.
#define WAIT_OBJECT_0  0x00000000u
#define WAIT_TIMEOUT   0x00000102u
#define WAIT_FAILED    0xFFFFFFFFu

// Frees the object. Waiting on a thread handle after closing it is undefined,
// exactly as on Win32.
BOOL CloseHandle(HANDLE handle);

// Blocks until the object signals or dwMilliseconds elapses. For a thread
// handle "signalled" means the thread has exited. Pass INFINITE to wait
// forever. Returns WAIT_OBJECT_0, WAIT_TIMEOUT or WAIT_FAILED.
DWORD WaitForSingleObject(HANDLE handle, DWORD dwMilliseconds);

#endif  // JX_COMPAT_WIN_HANDLE_H
