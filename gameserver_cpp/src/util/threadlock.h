// KThreadLock -- the mutex the shipped tree uses everywhere.
//
// In the binary it is a 28-byte class deriving from IKLock, with Lock and
// UnLock as virtuals. The virtual dispatch is not load-bearing here (nothing
// passes an IKLock across the .so boundary; libheaven.so has its own copy),
// so this is a plain class over compat's CRITICAL_SECTION.
//
// Recursive, because compat's CRITICAL_SECTION is -- Win32 critical sections
// are, and the JX code relies on it in the player and npc locks where an
// already-held section is re-entered through a helper.
#ifndef JX_UTIL_THREADLOCK_H
#define JX_UTIL_THREADLOCK_H

#include "windows.h"

class KThreadLock
{
public:
    KThreadLock()  { InitializeCriticalSection(&m_cs); }
    ~KThreadLock() { DeleteCriticalSection(&m_cs); }

    void Lock()   { EnterCriticalSection(&m_cs); }
    void UnLock() { LeaveCriticalSection(&m_cs); }

private:
    KThreadLock(const KThreadLock&);
    KThreadLock& operator=(const KThreadLock&);

    CRITICAL_SECTION m_cs;
};

#endif  // JX_UTIL_THREADLOCK_H
