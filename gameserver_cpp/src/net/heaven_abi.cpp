#include "heaven_abi.h"

#include <dlfcn.h>
#include <stdio.h>

// RTLD_NOW. The shipped binary passes the literal 2, and the difference is not
// cosmetic: with RTLD_LAZY an unresolved symbol inside heaven would surface as
// a crash on the first packet instead of a failure at startup.
static const int kDlopenFlags = RTLD_NOW;

bool KDll::Load(LPCSTR pszName)
{
    if (m_hDll)
        return true;

    char szFile[260];
    snprintf(szFile, 0x103u, "./lib%s.so", pszName);
    szFile[259] = 0;

    m_hDll = dlopen(szFile, kDlopenFlags);
    return m_hDll != 0;
}

void KDll::Unload()
{
    if (m_hDll)
    {
        dlclose(m_hDll);
        m_hDll = 0;
    }
}

void* KDll::Symbol(LPCSTR pszSymbol) const
{
    return m_hDll ? dlsym(m_hDll, pszSymbol) : 0;
}

bool KHeavenLib::Load()
{
    if (!m_cDll.Load("heaven"))
        return false;   // the original returns silently here too

    m_pfnCreate = (PFN_CreateServer)m_cDll.Symbol("CreateServer");
    if (!m_pfnCreate)
    {
        m_cDll.Unload();
        puts("Failed to export function from heaven");
        return false;
    }
    return true;
}

bool KRainbowLib::Load()
{
    if (!m_cDll.Load("rainbow"))
        return false;

    PFN_CreateClientManager pfn =
        (PFN_CreateClientManager)m_cDll.Symbol("CreateClientManager");

    // 6 is what the shipped server passes, and it is the count of outbound
    // links it will ever ask for: five (gateway, database, transfer, chat,
    // tong) plus one.
    if (!pfn || !pfn(6, &m_pClientManager))
    {
        m_cDll.Unload();
        puts("Failed to export function from rainbow");
        return false;
    }

    if (!m_pClientManager->Initialize())
    {
        m_pClientManager->Release();
        m_pClientManager = 0;
        m_cDll.Unload();
        puts("Failed to initialize client manager!");
        return false;
    }
    return true;
}

void KRainbowLib::Unload()
{
    if (m_pClientManager)
    {
        m_pClientManager->UnInitialize();
        m_pClientManager->Release();
        m_pClientManager = 0;
    }
    m_cDll.Unload();
}
