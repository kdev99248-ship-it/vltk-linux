// Implementation of the Win32 compat surface. See the individual headers for
// the rationale behind each group.

// pthread_timedjoin_np is a GNU extension; WaitForSingleObject on a thread
// handle with a finite timeout has no portable equivalent.
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <time.h>
#include <unistd.h>

#include "win_handle.h"
#include "win_sock.h"
#include "win_str.h"
#include "win_sync.h"
#include "win_thread.h"
#include "win_time.h"

// ---------------------------------------------------------------- critical section

void InitializeCriticalSection(LPCRITICAL_SECTION section) {
    if (!section) return;
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    // Win32 critical sections are recursive; the player and npc locks re-enter.
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    pthread_mutex_init(&section->mutex, &attr);
    pthread_mutexattr_destroy(&attr);
    section->initialised = true;
}

void DeleteCriticalSection(LPCRITICAL_SECTION section) {
    if (!section || !section->initialised) return;
    pthread_mutex_destroy(&section->mutex);
    section->initialised = false;
}

void EnterCriticalSection(LPCRITICAL_SECTION section) {
    if (!section) return;
    // Win32 allows a statically zeroed section only after Initialize; guard
    // anyway so a missed init is a lock, not a crash in the middle of a raid.
    if (!section->initialised) InitializeCriticalSection(section);
    pthread_mutex_lock(&section->mutex);
}

void LeaveCriticalSection(LPCRITICAL_SECTION section) {
    if (!section || !section->initialised) return;
    pthread_mutex_unlock(&section->mutex);
}

BOOL TryEnterCriticalSection(LPCRITICAL_SECTION section) {
    if (!section) return FALSE;
    if (!section->initialised) InitializeCriticalSection(section);
    return pthread_mutex_trylock(&section->mutex) == 0 ? TRUE : FALSE;
}

// ---------------------------------------------------------------- interlocked

LONG InterlockedIncrement(LONG volatile* addend) {
    return __atomic_add_fetch(addend, 1, __ATOMIC_SEQ_CST);
}

LONG InterlockedDecrement(LONG volatile* addend) {
    return __atomic_sub_fetch(addend, 1, __ATOMIC_SEQ_CST);
}

LONG InterlockedExchange(LONG volatile* target, LONG value) {
    return __atomic_exchange_n(target, value, __ATOMIC_SEQ_CST);
}

LONG InterlockedExchangeAdd(LONG volatile* addend, LONG value) {
    return __atomic_fetch_add(addend, value, __ATOMIC_SEQ_CST);
}

LONG InterlockedCompareExchange(LONG volatile* dest, LONG exchange, LONG comparand) {
    LONG expected = comparand;
    __atomic_compare_exchange_n(dest, &expected, exchange, false,
                                __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST);
    return expected;  // Win32 returns the initial value of *dest.
}

// ---------------------------------------------------------------- events

HANDLE CreateEvent(void* /*lpEventAttributes*/,
                   BOOL bManualReset,
                   BOOL bInitialState,
                   LPCSTR /*lpName*/) {
    KHandleObject* h = new KHandleObject();
    h->kind = KHANDLE_EVENT;
    pthread_mutex_init(&h->mutex, nullptr);
    pthread_cond_init(&h->cond, nullptr);
    h->signaled = bInitialState != FALSE;
    h->manual_reset = bManualReset != FALSE;
    h->detached = false;
    return h;
}

BOOL SetEvent(HANDLE event) {
    if (!event || event == INVALID_HANDLE_VALUE || event->kind != KHANDLE_EVENT)
        return FALSE;
    pthread_mutex_lock(&event->mutex);
    event->signaled = true;
    // A manual-reset event releases everyone; an auto-reset one releases a
    // single waiter, which then consumes the signal.
    if (event->manual_reset)
        pthread_cond_broadcast(&event->cond);
    else
        pthread_cond_signal(&event->cond);
    pthread_mutex_unlock(&event->mutex);
    return TRUE;
}

BOOL ResetEvent(HANDLE event) {
    if (!event || event == INVALID_HANDLE_VALUE || event->kind != KHANDLE_EVENT)
        return FALSE;
    pthread_mutex_lock(&event->mutex);
    event->signaled = false;
    pthread_mutex_unlock(&event->mutex);
    return TRUE;
}

// ---------------------------------------------------------------- handles

static void abs_deadline(DWORD ms, struct timespec* out) {
    clock_gettime(CLOCK_REALTIME, out);
    out->tv_sec  += static_cast<time_t>(ms / 1000u);
    out->tv_nsec += static_cast<long>((ms % 1000u) * 1000000L);
    if (out->tv_nsec >= 1000000000L) {
        out->tv_sec  += 1;
        out->tv_nsec -= 1000000000L;
    }
}

DWORD WaitForSingleObject(HANDLE handle, DWORD dwMilliseconds) {
    if (!handle || handle == INVALID_HANDLE_VALUE) return WAIT_FAILED;

    if (handle->kind == KHANDLE_THREAD) {
        if (dwMilliseconds == INFINITE) {
            return pthread_join(handle->thread, nullptr) == 0 ? WAIT_OBJECT_0
                                                              : WAIT_FAILED;
        }
        struct timespec deadline;
        abs_deadline(dwMilliseconds, &deadline);
        int rc = pthread_timedjoin_np(handle->thread, nullptr, &deadline);
        if (rc == 0) return WAIT_OBJECT_0;
        return rc == ETIMEDOUT ? WAIT_TIMEOUT : WAIT_FAILED;
    }

    pthread_mutex_lock(&handle->mutex);
    DWORD result = WAIT_OBJECT_0;
    if (dwMilliseconds == INFINITE) {
        while (!handle->signaled)
            pthread_cond_wait(&handle->cond, &handle->mutex);
    } else {
        struct timespec deadline;
        abs_deadline(dwMilliseconds, &deadline);
        int rc = 0;
        while (!handle->signaled && rc == 0)
            rc = pthread_cond_timedwait(&handle->cond, &handle->mutex, &deadline);
        if (!handle->signaled) result = (rc == ETIMEDOUT) ? WAIT_TIMEOUT : WAIT_FAILED;
    }
    // An auto-reset event is consumed by the waiter that observed it.
    if (result == WAIT_OBJECT_0 && !handle->manual_reset)
        handle->signaled = false;
    pthread_mutex_unlock(&handle->mutex);
    return result;
}

BOOL CloseHandle(HANDLE handle) {
    if (!handle || handle == INVALID_HANDLE_VALUE) return FALSE;
    if (handle->kind == KHANDLE_THREAD) {
        // Win32 CloseHandle on a thread drops the reference without joining;
        // detach so the thread's resources are reclaimed when it exits.
        if (!handle->detached) {
            pthread_detach(handle->thread);
            handle->detached = true;
        }
    } else {
        pthread_cond_destroy(&handle->cond);
        pthread_mutex_destroy(&handle->mutex);
    }
    delete handle;
    return TRUE;
}

// ---------------------------------------------------------------- threads

namespace {

struct ThreadStart {
    LPTHREAD_START_ROUTINE fn;
    LPVOID param;
};

void* thread_trampoline(void* arg) {
    ThreadStart* start = static_cast<ThreadStart*>(arg);
    LPTHREAD_START_ROUTINE fn = start->fn;
    LPVOID param = start->param;
    delete start;
    DWORD rc = fn(param);
    return reinterpret_cast<void*>(static_cast<uintptr_t>(rc));
}

}  // namespace

HANDLE CreateThread(void* /*lpThreadAttributes*/,
                    size_t dwStackSize,
                    LPTHREAD_START_ROUTINE lpStartAddress,
                    LPVOID lpParameter,
                    DWORD /*dwCreationFlags*/,
                    LPDWORD lpThreadId) {
    if (!lpStartAddress) return nullptr;

    pthread_attr_t attr;
    pthread_attr_init(&attr);
    if (dwStackSize > 0) pthread_attr_setstacksize(&attr, dwStackSize);

    ThreadStart* start = new ThreadStart{lpStartAddress, lpParameter};
    KHandleObject* h = new KHandleObject();
    h->kind = KHANDLE_THREAD;
    h->detached = false;
    h->signaled = false;
    h->manual_reset = false;

    int rc = pthread_create(&h->thread, &attr, thread_trampoline, start);
    pthread_attr_destroy(&attr);
    if (rc != 0) {
        delete start;
        delete h;
        return nullptr;
    }
    if (lpThreadId) *lpThreadId = static_cast<DWORD>(h->thread);
    return h;
}

uintptr_t _beginthreadex(void* /*security*/,
                         unsigned stack_size,
                         KBeginThreadRoutine start_address,
                         void* arglist,
                         unsigned /*initflag*/,
                         unsigned* thrdaddr) {
    DWORD tid = 0;
    HANDLE h = CreateThread(nullptr, stack_size,
                            reinterpret_cast<LPTHREAD_START_ROUTINE>(start_address),
                            arglist, 0, &tid);
    if (thrdaddr) *thrdaddr = static_cast<unsigned>(tid);
    return reinterpret_cast<uintptr_t>(h);
}

DWORD GetCurrentThreadId(void) {
    return static_cast<DWORD>(pthread_self());
}

// ---------------------------------------------------------------- time

DWORD GetTickCount(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    // Deliberately truncated to 32 bits: callers compare deltas and rely on
    // unsigned wraparound, same as Win32.
    return static_cast<DWORD>(static_cast<uint64_t>(ts.tv_sec) * 1000ull +
                              static_cast<uint64_t>(ts.tv_nsec) / 1000000ull);
}

DWORD timeGetTime(void) { return GetTickCount(); }

void Sleep(DWORD dwMilliseconds) {
    struct timespec ts;
    ts.tv_sec  = static_cast<time_t>(dwMilliseconds / 1000u);
    ts.tv_nsec = static_cast<long>((dwMilliseconds % 1000u) * 1000000L);
    while (nanosleep(&ts, &ts) == -1 && errno == EINTR) {
        // Resume the remainder rather than returning early.
    }
}

static void fill_systemtime(const struct tm& t, int millis, LPSYSTEMTIME out) {
    out->wYear         = static_cast<WORD>(t.tm_year + 1900);
    out->wMonth        = static_cast<WORD>(t.tm_mon + 1);
    out->wDayOfWeek    = static_cast<WORD>(t.tm_wday);
    out->wDay          = static_cast<WORD>(t.tm_mday);
    out->wHour         = static_cast<WORD>(t.tm_hour);
    out->wMinute       = static_cast<WORD>(t.tm_min);
    out->wSecond       = static_cast<WORD>(t.tm_sec);
    out->wMilliseconds = static_cast<WORD>(millis);
}

void GetLocalTime(LPSYSTEMTIME lpSystemTime) {
    if (!lpSystemTime) return;
    struct timespec ts;
    clock_gettime(CLOCK_REALTIME, &ts);
    struct tm t;
    localtime_r(&ts.tv_sec, &t);
    fill_systemtime(t, static_cast<int>(ts.tv_nsec / 1000000L), lpSystemTime);
}

void GetSystemTime(LPSYSTEMTIME lpSystemTime) {
    if (!lpSystemTime) return;
    struct timespec ts;
    clock_gettime(CLOCK_REALTIME, &ts);
    struct tm t;
    gmtime_r(&ts.tv_sec, &t);
    fill_systemtime(t, static_cast<int>(ts.tv_nsec / 1000000L), lpSystemTime);
}

BOOL QueryPerformanceCounter(LARGE_INTEGER* lpPerformanceCount) {
    if (!lpPerformanceCount) return FALSE;
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    lpPerformanceCount->QuadPart =
        static_cast<int64_t>(ts.tv_sec) * 1000000ll + ts.tv_nsec / 1000ll;
    return TRUE;
}

BOOL QueryPerformanceFrequency(LARGE_INTEGER* lpFrequency) {
    if (!lpFrequency) return FALSE;
    lpFrequency->QuadPart = 1000000ll;  // counter is in microseconds
    return TRUE;
}

// ---------------------------------------------------------------- sockets

int ioctlsocket(SOCKET s, long cmd, unsigned long* argp) {
    if (cmd == FIONBIO && argp) {
        int flags = fcntl(s, F_GETFL, 0);
        if (flags < 0) return SOCKET_ERROR;
        flags = (*argp != 0) ? (flags | O_NONBLOCK) : (flags & ~O_NONBLOCK);
        return fcntl(s, F_SETFL, flags) < 0 ? SOCKET_ERROR : 0;
    }
    return ::ioctl(s, static_cast<unsigned long>(cmd), argp);
}

// ---------------------------------------------------------------- strings

char* jx_strupr(char* s) {
    if (!s) return s;
    for (char* p = s; *p; ++p)
        *p = static_cast<char>(toupper(static_cast<unsigned char>(*p)));
    return s;
}

char* jx_strlwr(char* s) {
    if (!s) return s;
    for (char* p = s; *p; ++p)
        *p = static_cast<char>(tolower(static_cast<unsigned char>(*p)));
    return s;
}

char* itoa(int value, char* str, int radix) {
    if (!str) return str;
    if (radix < 2 || radix > 36) { str[0] = '\0'; return str; }

    // Work on the unsigned magnitude so INT_MIN does not overflow on negation.
    bool negative = (value < 0 && radix == 10);
    unsigned int magnitude = negative ? static_cast<unsigned int>(-(static_cast<long long>(value)))
                                      : static_cast<unsigned int>(value);
    char buf[36];
    int n = 0;
    do {
        unsigned int digit = magnitude % static_cast<unsigned int>(radix);
        buf[n++] = static_cast<char>(digit < 10 ? '0' + digit : 'a' + digit - 10);
        magnitude /= static_cast<unsigned int>(radix);
    } while (magnitude);

    char* out = str;
    if (negative) *out++ = '-';
    while (n > 0) *out++ = buf[--n];
    *out = '\0';
    return str;
}

void OutputDebugString(LPCSTR text) {
    if (text) fputs(text, stderr);
}

DWORD GetLastError(void) { return static_cast<DWORD>(errno); }
void SetLastError(DWORD code) { errno = static_cast<int>(code); }

DWORD GetModuleFileName(HMODULE /*module*/, LPSTR filename, DWORD size) {
    if (!filename || size == 0) return 0;
    ssize_t n = readlink("/proc/self/exe", filename, size - 1);
    if (n < 0) { filename[0] = '\0'; return 0; }
    filename[n] = '\0';
    return static_cast<DWORD>(n);
}

// ---------------------------------------------------------------- ini files

namespace {

// Trims ASCII whitespace in place and returns the start of the trimmed span.
char* trim(char* s) {
    while (*s == ' ' || *s == '\t') ++s;
    char* end = s + strlen(s);
    while (end > s && (end[-1] == ' ' || end[-1] == '\t' ||
                       end[-1] == '\r' || end[-1] == '\n'))
        --end;
    *end = '\0';
    return s;
}

}  // namespace

DWORD GetPrivateProfileString(LPCSTR section, LPCSTR key, LPCSTR def,
                              LPSTR out, DWORD size, LPCSTR file) {
    if (!out || size == 0) return 0;
    out[0] = '\0';

    FILE* fh = file ? fopen(file, "r") : nullptr;
    bool found = false;
    if (fh) {
        char line[1024];
        bool in_section = (section == nullptr);
        while (fgets(line, sizeof(line), fh)) {
            char* p = trim(line);
            if (*p == '\0' || *p == ';' || *p == '#') continue;
            if (*p == '[') {
                char* close = strchr(p, ']');
                if (!close) continue;
                *close = '\0';
                in_section = section && strcasecmp(p + 1, section) == 0;
                continue;
            }
            if (!in_section) continue;
            char* eq = strchr(p, '=');
            if (!eq) continue;
            *eq = '\0';
            if (key && strcasecmp(trim(p), key) == 0) {
                snprintf(out, size, "%s", trim(eq + 1));
                found = true;
                break;
            }
        }
        fclose(fh);
    }
    if (!found) snprintf(out, size, "%s", def ? def : "");
    return static_cast<DWORD>(strlen(out));
}

UINT GetPrivateProfileInt(LPCSTR section, LPCSTR key, INT def, LPCSTR file) {
    char buf[64];
    char fallback[32];
    snprintf(fallback, sizeof(fallback), "%d", def);
    GetPrivateProfileString(section, key, fallback, buf, sizeof(buf), file);
    return static_cast<UINT>(strtol(buf, nullptr, 0));
}
