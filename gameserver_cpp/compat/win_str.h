// String, memory and debug-output shims.
#ifndef JX_COMPAT_WIN_STR_H
#define JX_COMPAT_WIN_STR_H

#include <string.h>
#include <strings.h>

#include "win_types.h"

#define ZeroMemory(dest, len)       memset((dest), 0, (len))
#define CopyMemory(dest, src, len)  memcpy((dest), (src), (len))
#define MoveMemory(dest, src, len)  memmove((dest), (src), (len))
#define FillMemory(dest, len, fill) memset((dest), (fill), (len))

#define _stricmp  strcasecmp
#define stricmp   strcasecmp
#define _strnicmp strncasecmp
#define strnicmp  strncasecmp
#define _strupr   jx_strupr
#define strupr    jx_strupr
#define _strlwr   jx_strlwr
#define strlwr    jx_strlwr
#define _snprintf snprintf
#define _vsnprintf vsnprintf

char* jx_strupr(char* s);
char* jx_strlwr(char* s);

// MSVC's non-standard itoa. Only radix 10 and 16 appear in the tree; other
// radices are supported anyway so a stray call does not silently truncate.
char* itoa(int value, char* str, int radix);
#define _itoa itoa

// Writes to stderr. The tree calls this from error paths only.
void OutputDebugString(LPCSTR text);
#define OutputDebugStringA OutputDebugString

// The last-error channel. Backed by errno, which is what every Linux call in
// the ported code sets anyway.
DWORD GetLastError(void);
void SetLastError(DWORD code);

// .ini reading. The tree has its own KIniFile for game data and only uses these
// four call sites for the launcher config, so the implementation is deliberately
// minimal: no quoted values, no section merging.
DWORD GetPrivateProfileString(LPCSTR section, LPCSTR key, LPCSTR def,
                              LPSTR out, DWORD size, LPCSTR file);
UINT GetPrivateProfileInt(LPCSTR section, LPCSTR key, INT def, LPCSTR file);

// Returns the running executable's path, via /proc/self/exe.
DWORD GetModuleFileName(HMODULE module, LPSTR filename, DWORD size);
#define GetModuleFileNameA GetModuleFileName

#endif  // JX_COMPAT_WIN_STR_H
