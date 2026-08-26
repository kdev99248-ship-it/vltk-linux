// Critical sections, interlocked arithmetic and event objects.
//
// Win32 critical sections are recursive; pthread mutexes are not by default, so
// the compat one is initialised RECURSIVE. The JX code relies on that in the
// player/npc locks, where an already-held section is re-entered through a
// helper call.
#ifndef JX_COMPAT_WIN_SYNC_H
#define JX_COMPAT_WIN_SYNC_H

#include <pthread.h>

#include "win_handle.h"
#include "win_types.h"

typedef struct _CRITICAL_SECTION {
    pthread_mutex_t mutex;
    bool            initialised;
} CRITICAL_SECTION, *LPCRITICAL_SECTION;

void InitializeCriticalSection(LPCRITICAL_SECTION section);
void DeleteCriticalSection(LPCRITICAL_SECTION section);
void EnterCriticalSection(LPCRITICAL_SECTION section);
void LeaveCriticalSection(LPCRITICAL_SECTION section);
BOOL TryEnterCriticalSection(LPCRITICAL_SECTION section);

// Win32 semantics, which differ between these two and are easy to get wrong:
// Increment/Decrement return the NEW value, Exchange returns the OLD one.
LONG InterlockedIncrement(LONG volatile* addend);
LONG InterlockedDecrement(LONG volatile* addend);
LONG InterlockedExchange(LONG volatile* target, LONG value);
LONG InterlockedExchangeAdd(LONG volatile* addend, LONG value);
LONG InterlockedCompareExchange(LONG volatile* dest, LONG exchange, LONG comparand);

// lpEventAttributes is always NULL in this tree and is ignored. A named event
// (lpName != NULL) is NOT cross-process here -- the name is accepted and
// dropped, because every call site in the tree is single-process.
HANDLE CreateEvent(void* lpEventAttributes,
                   BOOL bManualReset,
                   BOOL bInitialState,
                   LPCSTR lpName);
BOOL SetEvent(HANDLE event);
BOOL ResetEvent(HANDLE event);

#endif  // JX_COMPAT_WIN_SYNC_H
