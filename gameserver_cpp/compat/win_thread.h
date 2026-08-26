// Thread creation. Both spellings the tree uses map onto the same pthread call.
#ifndef JX_COMPAT_WIN_THREAD_H
#define JX_COMPAT_WIN_THREAD_H

#include "win_handle.h"
#include "win_types.h"

typedef DWORD (WINAPI *LPTHREAD_START_ROUTINE)(LPVOID lpParameter);

// lpThreadAttributes and dwCreationFlags are ignored: every call site in the
// tree passes NULL and 0. lpThreadId receives the pthread id when non-NULL.
HANDLE CreateThread(void* lpThreadAttributes,
                    size_t dwStackSize,
                    LPTHREAD_START_ROUTINE lpStartAddress,
                    LPVOID lpParameter,
                    DWORD dwCreationFlags,
                    LPDWORD lpThreadId);

// The CRT spelling, used in 6 places. Signature differs from CreateThread in
// return type and in the routine's calling convention only.
typedef unsigned (WINAPI *KBeginThreadRoutine)(void* arg);
uintptr_t _beginthreadex(void* security,
                         unsigned stack_size,
                         KBeginThreadRoutine start_address,
                         void* arglist,
                         unsigned initflag,
                         unsigned* thrdaddr);

DWORD GetCurrentThreadId(void);

#endif  // JX_COMPAT_WIN_THREAD_H
