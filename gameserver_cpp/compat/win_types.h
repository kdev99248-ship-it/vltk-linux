// Win32 scalar types and constants, for building the JX server sources on Linux.
//
// Every name here was found by scanning Sources/Core, Sources/MultiServer and
// Sources/Library of the Windows tree -- nothing is defined speculatively.
// Widths match Win32 on i386, which is also what the shipped jx_linux_y is, so
// struct layouts carry over byte for byte.
#ifndef JX_COMPAT_WIN_TYPES_H
#define JX_COMPAT_WIN_TYPES_H

#include <stddef.h>
#include <stdint.h>

typedef uint8_t  BYTE;
typedef uint8_t  UCHAR;
typedef char     CHAR;
typedef uint16_t WORD;
typedef uint16_t USHORT;
typedef uint32_t DWORD;
typedef uint32_t ULONG;
typedef uint32_t UINT;
typedef int32_t  LONG;
typedef int32_t  INT;
typedef int32_t  BOOL;
typedef float    FLOAT;

typedef char*        LPSTR;
typedef const char*  LPCSTR;
typedef void*        LPVOID;
typedef const void*  LPCVOID;
typedef BYTE*        LPBYTE;
typedef DWORD*       LPDWORD;

typedef intptr_t  LPARAM;
typedef uintptr_t WPARAM;
typedef intptr_t  LRESULT;

typedef void* HMODULE;
typedef void* HINSTANCE;

// MSVC spelling used throughout the tree.
typedef int64_t  __int64_compat;
#ifndef __int64
#define __int64 long long
#endif

// Win32 marks exported/callback functions with these; on Linux they vanish.
#define WINAPI
#define CALLBACK
#define APIENTRY
#define __stdcall
#define __cdecl

#ifndef TRUE
#define TRUE  1
#endif
#ifndef FALSE
#define FALSE 0
#endif

#ifndef MAX_PATH
#define MAX_PATH 260
#endif

#ifndef INFINITE
#define INFINITE 0xFFFFFFFFu
#endif

typedef union _LARGE_INTEGER {
    struct { DWORD LowPart; LONG HighPart; };
    struct { DWORD LowPart; LONG HighPart; } u;
    int64_t QuadPart;
} LARGE_INTEGER;

typedef struct _SYSTEMTIME {
    WORD wYear;
    WORD wMonth;
    WORD wDayOfWeek;
    WORD wDay;
    WORD wHour;
    WORD wMinute;
    WORD wSecond;
    WORD wMilliseconds;
} SYSTEMTIME, *LPSYSTEMTIME;

typedef struct _FILETIME {
    DWORD dwLowDateTime;
    DWORD dwHighDateTime;
} FILETIME, *LPFILETIME;

// GUID appears by value inside packed protocol structs (tagGuidableInfo and
// five others in KProtocol.h), so this is a wire layout, not a convenience
// typedef: it must stay exactly 16 bytes with Win32's field order and sizes.
// Asserted below rather than trusted.
typedef struct _GUID {
    DWORD Data1;
    WORD  Data2;
    WORD  Data3;
    BYTE  Data4[8];
} GUID;

// POINT is embedded in KMapTraffic (GameDataDef.h) and travels with it, so the
// two LONGs and their order are fixed by the original layout.
typedef struct tagPOINT {
    LONG x;
    LONG y;
} POINT, *LPPOINT;

typedef GUID UUID;
typedef GUID* LPGUID;
typedef const GUID* LPCGUID;
typedef GUID IID;
typedef GUID CLSID;

#ifdef __cplusplus
static_assert(sizeof(GUID) == 16, "GUID must be 16 bytes to match the wire format");
#endif

#endif  // JX_COMPAT_WIN_TYPES_H
