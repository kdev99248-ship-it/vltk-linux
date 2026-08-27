#include "logfile.h"

#include <stdarg.h>
#include <string.h>
#include <sys/stat.h>
#include <time.h>

// The rollover threshold, 0x3FFFFFFF. One byte short of a gigabyte, which is
// what a 32-bit signed size_t comparison can be trusted with.
static const size_t kMaxFileSize = 0x3FFFFFFFu;

// KSG_LogFile::s_uCurDayOfYear @ 0x0949B684. A process-wide note of what day it
// is, written by every log write and read by nothing in the code recovered so
// far. Kept because it is shared state: something in the rest of the tree
// almost certainly reads it, and finding it missing later is worse than
// carrying four unused bytes.
static UINT s_uCurDayOfYear = 0;

KSG_LogFile::KSG_LogFile(LPCSTR pszFileName)
    : m_pLog(0), m_uDayOfYear(0), m_bFileNameAutoChangeWithDate(0),
      m_nLevel(emLOGLEVEL_INFO), m_nFileSize(0)
{
    m_szFileNameKey[0] = 0;
    m_szSuffixName[0] = 0;
    m_szFile[0] = 0;

    if (pszFileName)
        Init(pszFileName);
}

KSG_LogFile::~KSG_LogFile()
{
    if (m_pLog)
    {
        fclose(m_pLog);
        m_pLog = 0;
    }
}

BOOL KSG_LogFile::Init(LPCSTR pszFile)
{
    if (!pszFile || !*pszFile)
        return 0;

    if (m_pLog)
    {
        fclose(m_pLog);
        m_pLog = 0;
    }

    // The original routes this through g_GetFullPath, which prefixes the
    // engine's root path. Initialize calls g_SetRootPath(0), which leaves that
    // prefix empty, so the two agree -- the file lands relative to the working
    // directory either way. Revisit if the package VFS lands with a real root.
    m_pLog = fopen(pszFile, "ab+");
    if (!m_pLog)
        return 0;

    struct stat sInf;
    memset(&sInf, 0, sizeof(sInf));
    m_nFileSize = (stat(pszFile, &sInf) != 0) ? 0 : (size_t)sInf.st_size;

    strncpy(m_szFile, pszFile, 0x103u);
    m_szFile[259] = 0;
    return 1;
}

BOOL KSG_LogFile::InitWithDate(LPCSTR pcszKeyName, LPCSTR pcszSuffixName,
                               BOOL bEveryDayChangeFile)
{
    if (!pcszKeyName || !*pcszKeyName)
        return 0;

    char szFileName[1024];
    const time_t tmCurrent = time(0);
    const struct tm* t = localtime(&tmCurrent);
    if (t)
    {
        snprintf(szFileName, 0x3FFu, "%s_%04d%02d%02d.%s", pcszKeyName,
                 t->tm_year + 1900, t->tm_mon + 1, t->tm_mday, pcszSuffixName);
        m_uDayOfYear = (UINT)t->tm_yday;
    }
    else
    {
        snprintf(szFileName, 0x3FFu, "%s.%s", pcszKeyName, pcszSuffixName);
    }
    szFileName[1023] = 0;

    strncpy(m_szFileNameKey, pcszKeyName, 0x103u);
    m_szFileNameKey[259] = 0;
    strncpy(m_szSuffixName, pcszSuffixName, 0x13u);
    m_szSuffixName[19] = 0;
    m_bFileNameAutoChangeWithDate = bEveryDayChangeFile;

    return Init(szFileName);
}

void KSG_LogFile::WriteLog(LPCSTR pszMsg, size_t nLen)
{
    if (!m_pLog)
        return;

    const int nWritten = (int)fwrite(pszMsg, 1, nLen, m_pLog);
    if (nWritten > 0)
    {
        m_nFileSize += (size_t)nWritten;
        // Flushed on every line. Expensive, and deliberate: a server that dies
        // is exactly when its last log line matters.
        fflush(m_pLog);
        if (m_nFileSize > kMaxFileSize)
            OpenNewFile();
    }
}

// Rolls over to "<name>_<n>.<ext>" for the first n in 1..999 whose file is
// either absent or under the threshold. Gives up at 1000 rather than growing
// the name.
BOOL KSG_LogFile::OpenNewFile()
{
    char szFile[260];
    strncpy(szFile, m_szFile, 0x103u);
    szFile[259] = 0;

    const char* pszSuffix = "";
    char* pDot = strrchr(szFile, '.');
    if (pDot > szFile)
    {
        *pDot = 0;
        pszSuffix = pDot + 1;
    }

    for (int n = 1; n != 1000; ++n)
    {
        char szPath[520];
        snprintf(szPath, sizeof(szPath), "%s_%d.%s", szFile, n, pszSuffix);
        szPath[sizeof(szPath) - 1] = 0;

        struct stat sInf;
        memset(&sInf, 0, sizeof(sInf));
        if (stat(szPath, &sInf) != 0 || (size_t)sInf.st_size <= kMaxFileSize)
        {
            FILE* pNew = fopen(szPath, "ab+");
            if (pNew)
            {
                if (m_pLog)
                    fclose(m_pLog);
                m_pLog = pNew;
                m_nFileSize = (size_t)sInf.st_size;
                return 1;
            }
        }
    }
    return 0;
}

void KSG_LogFile::write_date_time()
{
    if (!m_pLog)
        return;

    const time_t tmCurrent = time(0);
    const struct tm* t = localtime(&tmCurrent);
    if (!t)
        return;

    const BOOL bAuto = m_bFileNameAutoChangeWithDate;
    s_uCurDayOfYear = (UINT)t->tm_yday;
    if (bAuto && (UINT)t->tm_yday != m_uDayOfYear)
        InitWithDate(m_szFileNameKey, m_szSuffixName, 1);

    char szDateTime[256];
    sprintf(szDateTime, "%04d-%02d-%02d %02d:%02d:%02d\t",
            t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
            t->tm_hour, t->tm_min, t->tm_sec);
    WriteLog(szDateTime, strlen(szDateTime));
}

void KSG_LogFile::puts(LPCSTR pcszString)
{
    if (!pcszString || !*pcszString)
        return;

    // The date check happens again here, not only in write_date_time: puts is
    // also reachable without a timestamp.
    if (m_bFileNameAutoChangeWithDate)
    {
        const time_t tmCurrent = time(0);
        const struct tm* t = localtime(&tmCurrent);
        if (t)
        {
            const bool bSameDay = ((UINT)t->tm_yday == m_uDayOfYear);
            s_uCurDayOfYear = (UINT)t->tm_yday;
            if (!bSameDay)
                InitWithDate(m_szFileNameKey, m_szSuffixName, 1);
        }
    }

    WriteLog(pcszString, strlen(pcszString));
}

void KSG_LogFile::puts_t(LPCSTR pcszString)
{
    write_date_time();
    puts(pcszString);
}

void KSG_LogFile::printf_t(LPCSTR pcszFmt, ...)
{
    if (!m_pLog || !pcszFmt)
        return;

    char szBuffer[1024];
    szBuffer[0] = 0;

    va_list va;
    va_start(va, pcszFmt);
    // vsnprintf, not the original's vsprintf. The buffer is the same 1024
    // bytes; the original will run off the end of it given a long enough
    // formatted line, and reproducing a stack smash is not fidelity.
    vsnprintf(szBuffer, sizeof(szBuffer), pcszFmt, va);
    va_end(va);

    puts_t(szBuffer);
}
