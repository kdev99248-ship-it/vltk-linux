// A minimal KIniFile.
//
// This is a reimplementation, not a port. The shipped KIniFile reads through
// the engine's package VFS (g_InitEngine("package.ini", ...) runs before the
// first Load, and paths like "\\settings\\product_config.ini" are VFS paths,
// not filesystem ones), and reproducing that means porting the packfile layer
// first. What Phase 1 needs is servercfg.ini, which the server loads by plain
// relative path.
//
// So the surface is exactly the three methods the startup path calls, with the
// signatures the binary's manglings give:
//
//     _ZN8KIniFile4LoadEPKc
//     _ZN8KIniFile10GetIntegerEPKcS1_iPi
//     _ZN8KIniFile9GetStringEPKcS1_S1_Pcm
//
// When the VFS lands, this class gets a different Load and its callers do not
// change.
#ifndef JX_UTIL_INIFILE_H
#define JX_UTIL_INIFILE_H

#include <map>
#include <string>

#include "windows.h"

class KIniFile
{
public:
    // Reads the whole file. Returns FALSE if it cannot be opened; an empty or
    // malformed file loads as empty, which is how every GetX call then falls
    // through to its default.
    //
    // Backslashes in the path are translated to '/', because the shipped code
    // writes VFS paths in the Windows style even on Linux.
    BOOL Load(LPCSTR pszFileName);

    // Section and key are matched case-insensitively, as Win32's profile API
    // does and as the .ini files in the deployed tree assume.
    //
    // GetInteger's default is normally the caller's current value --
    // KSOServer::LoadConnection passes &pConnection->nPort as both -- so an
    // absent key leaves the field alone.
    BOOL GetInteger(LPCSTR pszSection, LPCSTR pszKey, int nDefault, int* pnValue) const;

    // Writes at most nSize bytes INCLUDING the terminator; call sites pass the
    // full buffer size (0x104 for a char[260], 0x10 for the 16-byte szIp), so a
    // longer value is truncated rather than overflowing.
    BOOL GetString(LPCSTR pszSection, LPCSTR pszKey, LPCSTR pszDefault,
                   char* pszBuf, size_t nSize) const;

private:
    const std::string* Find(LPCSTR pszSection, LPCSTR pszKey) const;

    typedef std::map<std::string, std::string> KEYS;
    std::map<std::string, KEYS> m_mapSections;
};

#endif  // JX_UTIL_INIFILE_H
