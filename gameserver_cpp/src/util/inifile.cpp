#include "inifile.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

namespace {

std::string Lower(const char* p)
{
    std::string s(p ? p : "");
    for (size_t i = 0; i < s.size(); ++i)
        if (s[i] >= 'A' && s[i] <= 'Z')
            s[i] = (char)(s[i] - 'A' + 'a');
    return s;
}

void Trim(std::string& s)
{
    // \r is not incidental: the deployed .ini files are CRLF, and a trailing
    // \r on a port number turns strtol into a silent 0.
    const char* kSpace = " \t\r\n";
    size_t b = s.find_first_not_of(kSpace);
    if (b == std::string::npos)
    {
        s.clear();
        return;
    }
    size_t e = s.find_last_not_of(kSpace);
    s = s.substr(b, e - b + 1);
}

}  // namespace

BOOL KIniFile::Load(LPCSTR pszFileName)
{
    m_mapSections.clear();
    if (!pszFileName)
        return FALSE;

    std::string sPath(pszFileName);
    for (size_t i = 0; i < sPath.size(); ++i)
        if (sPath[i] == '\\')
            sPath[i] = '/';

    FILE* fp = fopen(sPath.c_str(), "rb");
    if (!fp)
        return FALSE;

    char szLine[1024];
    std::string sSection;
    while (fgets(szLine, sizeof(szLine), fp))
    {
        std::string sLine(szLine);
        Trim(sLine);
        if (sLine.empty() || sLine[0] == ';' || sLine[0] == '#')
            continue;

        if (sLine[0] == '[')
        {
            size_t e = sLine.find(']');
            if (e == std::string::npos)
                continue;
            sSection = sLine.substr(1, e - 1);
            Trim(sSection);
            sSection = Lower(sSection.c_str());
            continue;
        }

        size_t eq = sLine.find('=');
        if (eq == std::string::npos)
            continue;

        std::string sKey = sLine.substr(0, eq);
        std::string sVal = sLine.substr(eq + 1);
        Trim(sKey);
        Trim(sVal);
        if (sKey.empty())
            continue;

        // First occurrence wins, matching the behaviour a duplicated key gets
        // from the deployed files today.
        KEYS& keys = m_mapSections[sSection];
        if (keys.find(Lower(sKey.c_str())) == keys.end())
            keys[Lower(sKey.c_str())] = sVal;
    }

    fclose(fp);
    return TRUE;
}

const std::string* KIniFile::Find(LPCSTR pszSection, LPCSTR pszKey) const
{
    std::map<std::string, KEYS>::const_iterator s =
        m_mapSections.find(Lower(pszSection));
    if (s == m_mapSections.end())
        return 0;
    KEYS::const_iterator k = s->second.find(Lower(pszKey));
    if (k == s->second.end())
        return 0;
    return &k->second;
}

BOOL KIniFile::GetInteger(LPCSTR pszSection, LPCSTR pszKey, int nDefault,
                          int* pnValue) const
{
    if (!pnValue)
        return FALSE;

    const std::string* pVal = Find(pszSection, pszKey);
    if (!pVal || pVal->empty())
    {
        *pnValue = nDefault;
        return FALSE;
    }

    // Base 0, so 0x-prefixed values work. Nothing in servercfg.ini uses them,
    // but the buffer sizes elsewhere in the tree do.
    *pnValue = (int)strtol(pVal->c_str(), 0, 0);
    return TRUE;
}

BOOL KIniFile::GetString(LPCSTR pszSection, LPCSTR pszKey, LPCSTR pszDefault,
                         char* pszBuf, size_t nSize) const
{
    if (!pszBuf || nSize == 0)
        return FALSE;

    const std::string* pVal = Find(pszSection, pszKey);
    const char* pszSrc = pVal ? pVal->c_str() : (pszDefault ? pszDefault : "");

    size_t n = strlen(pszSrc);
    if (n > nSize - 1)
        n = nSize - 1;
    memcpy(pszBuf, pszSrc, n);
    pszBuf[n] = 0;

    return pVal != 0;
}
