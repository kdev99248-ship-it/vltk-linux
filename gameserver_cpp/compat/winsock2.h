// Alias so sources that include <winsock2.h> resolve to the socket shims.
// Kept out of the windows.h umbrella on purpose: on Win32 the two headers
// conflict unless winsock2.h comes first, and mirroring that split here keeps
// the ported includes honest.
#ifndef JX_COMPAT_WINSOCK2_H
#define JX_COMPAT_WINSOCK2_H

#include "win_sock.h"

#endif  // JX_COMPAT_WINSOCK2_H
