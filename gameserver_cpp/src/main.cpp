// gameserver entry point -- main @ 0x0804AD10.
//
// The whole of it: parse three possible arguments, lift the core-dump limit,
// construct KSOServer, run until it stops.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/time.h>

#include "ksoserver.h"

static const char* const kBuildVersion = "3, 0, 0, 70";

int main(int argc, char* argv[])
{
    int  nPort   = 0;
    BOOL bOpenGm = 0;

    // Three forms, and the parse is loose in the shipped way: "-v" prints and
    // exits, "gm" opens the GM commands, and anything that strtol reads as a
    // positive number is the port. An unrecognised argument is ignored.
    for (int i = 1; i < argc; ++i)
    {
        if (strcmp(argv[i], "-v") == 0)
        {
            printf("Build version: %s\n", kBuildVersion);
            return 0;
        }

        if (strcmp(argv[i], "gm") == 0)
        {
            bOpenGm = 1;
        }
        else
        {
            const long nValue = strtol(argv[i], 0, 10);
            if (nValue > 0)
                nPort = (int)nValue;
        }
    }

    // RLIM_INFINITY. A server this size is debugged from core files, so the
    // limit comes off before anything can crash.
    struct rlimit sLimit;
    sLimit.rlim_cur = RLIM_INFINITY;
    sLimit.rlim_max = RLIM_INFINITY;
    setrlimit(RLIMIT_CORE, &sLimit);

    // On the stack, as in the original -- 3.5 KB of object, and its lifetime is
    // the process's.
    KSOServer cApp;

    int nResult = -1;
    if (cApp.Initialize(nPort, bOpenGm))
    {
        cApp.Run();
        cApp.UnInitialize();
        nResult = 0;
    }
    return nResult;
}
