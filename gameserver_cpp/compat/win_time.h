// Clocks and sleeping.
//
// GetTickCount and timeGetTime both read CLOCK_MONOTONIC, so they cannot jump
// when the wall clock is adjusted. Both wrap at 2^32 ms (~49.7 days) exactly as
// on Win32 -- the JX code compares tick deltas rather than absolutes, so the
// wrap is harmless, but do not "fix" it to 64-bit: some comparisons rely on the
// unsigned wraparound arithmetic.
#ifndef JX_COMPAT_WIN_TIME_H
#define JX_COMPAT_WIN_TIME_H

#include "win_types.h"

DWORD GetTickCount(void);
DWORD timeGetTime(void);

void Sleep(DWORD dwMilliseconds);

// Local wall clock (GetLocalTime) and UTC (GetSystemTime).
void GetLocalTime(LPSYSTEMTIME lpSystemTime);
void GetSystemTime(LPSYSTEMTIME lpSystemTime);

// Backed by CLOCK_MONOTONIC with a fixed 1 MHz frequency, so the counter is in
// microseconds and QueryPerformanceFrequency always reports 1000000.
BOOL QueryPerformanceCounter(LARGE_INTEGER* lpPerformanceCount);
BOOL QueryPerformanceFrequency(LARGE_INTEGER* lpFrequency);

#endif  // JX_COMPAT_WIN_TIME_H
