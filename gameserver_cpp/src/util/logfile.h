// KSG_LogFile -- the log sink every long-lived object in the server owns one of.
//
// Ported now because CClientConnection has one as a member: each of the five
// outbound links opens Logs/conn_<name>_<date>.log when it connects, and the
// link's own traffic goes there rather than to stdout. The class is also what
// g_GameServerLog and g_LoginOutLogFile are, so the rest of Phase 2 gets it for
// free.
//
// Recovered from the DWARF layout (564 bytes) and the bodies at:
//
//     KSG_LogFile::KSG_LogFile   @ 0x08217A10
//     KSG_LogFile::Init          @ 0x082171B0
//     KSG_LogFile::InitWithDate  @ 0x082172A0
//     KSG_LogFile::WriteLog      @ 0x08216FE0
//     KSG_LogFile::OpenNewFile   @ 0x08216CB0
//     KSG_LogFile::puts          @ 0x08217810
//     KSG_LogFile::puts_t        @ 0x082178B0
//     KSG_LogFile::printf_t      @ 0x082178E0
//     KSG_LogFile::write_date_time @ 0x082174D0
//
// The _t suffix means "timestamped": puts_t writes the date and time first,
// then the line. printf_t is puts_t with formatting, and is what nearly every
// caller uses.
#ifndef JX_UTIL_LOGFILE_H
#define JX_UTIL_LOGFILE_H

#include <stdio.h>

#include "windows.h"

enum KE_LOGLEVEL
{
    emLOGLEVEL_DEBUG = 0,
    emLOGLEVEL_INFO  = 1,
    emLOGLEVEL_WARN  = 2,
    emLOGLEVEL_ERROR = 3,
};

class KSG_LogFile
{
public:
    explicit KSG_LogFile(LPCSTR pszFileName = 0);
    virtual ~KSG_LogFile();

    // Opens pszFile for append. The name is taken as given.
    BOOL Init(LPCSTR pszFile);

    // Opens "<key>_<YYYYMMDD>.<suffix>". With bEveryDayChangeFile set, every
    // subsequent write checks the day of the year and rolls the file over when
    // it changes -- which is why the key and suffix are stored.
    BOOL InitWithDate(LPCSTR pcszKeyName, LPCSTR pcszSuffixName,
                      BOOL bEveryDayChangeFile);

    void puts(LPCSTR pcszString);
    void puts_t(LPCSTR pcszString);
    void printf_t(LPCSTR pcszFmt, ...) __attribute__((format(printf, 2, 3)));

    BOOL IsOpen() const { return m_pLog != 0; }

private:
    KSG_LogFile(const KSG_LogFile&);
    KSG_LogFile& operator=(const KSG_LogFile&);

    void WriteLog(LPCSTR pszMsg, size_t nLen);
    void write_date_time();
    BOOL OpenNewFile();

    FILE*       m_pLog;
    UINT        m_uDayOfYear;
    BOOL        m_bFileNameAutoChangeWithDate;
    char        m_szFileNameKey[260];
    char        m_szSuffixName[20];
    KE_LOGLEVEL m_nLevel;
    size_t      m_nFileSize;
    char        m_szFile[260];
};

#endif  // JX_UTIL_LOGFILE_H
