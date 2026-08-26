// Umbrella header, so the 37 files in the Windows tree that say
// `#include <windows.h>` compile unchanged once compat/ is on the include path.
//
// Nothing here is a general-purpose Win32 emulation -- it covers exactly the API
// surface the JX server sources use, and nothing else. Adding a name means
// first confirming a call site needs it.
#ifndef JX_COMPAT_WINDOWS_H
#define JX_COMPAT_WINDOWS_H

#include "win_types.h"
#include "win_handle.h"
#include "win_sync.h"
#include "win_thread.h"
#include "win_time.h"
#include "win_str.h"

#endif  // JX_COMPAT_WINDOWS_H
