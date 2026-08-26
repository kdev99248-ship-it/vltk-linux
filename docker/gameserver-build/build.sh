#!/usr/bin/env bash
# Configure and build gameserver_cpp inside the toolchain container.
#
# The host is not expected to have gcc, cmake or make -- this script is the
# supported way to compile. Both source trees are bind-mounted read-only so a
# container cannot corrupt them; only the build directory is writable.
#
#   ./docker/gameserver-build/build.sh                 # RelWithDebInfo
#   ./docker/gameserver-build/build.sh Debug           # + ASAN/UBSAN
#   ./docker/gameserver-build/build.sh Debug struct_probe
set -euo pipefail

BUILD_TYPE="${1:-RelWithDebInfo}"
TARGET="${2:-all}"

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="$(cd "$HERE/../.." && pwd)"

# The Windows source tree is outside the repo. Override for a different layout:
#   JX_WIN_SOURCE=/path/to/SwordOnline ./docker/gameserver-build/build.sh
JX_WIN_SOURCE="${JX_WIN_SOURCE:-$REPO/../Source/Source/SwordOnline}"

if [[ ! -f "$JX_WIN_SOURCE/Headers/KProtocol.h" ]]; then
    echo "error: no SwordOnline tree at $JX_WIN_SOURCE" >&2
    echo "       set JX_WIN_SOURCE to the directory containing Headers/" >&2
    exit 1
fi
JX_WIN_SOURCE="$(cd "$JX_WIN_SOURCE" && pwd)"

IMAGE=jx-gameserver-build
docker build -t "$IMAGE" -f "$HERE/Dockerfile" "$HERE"

mkdir -p "$REPO/gameserver_cpp/build/docker"

docker run --rm \
    -v "$REPO/gameserver_cpp:/src:ro" \
    -v "$JX_WIN_SOURCE:/jxwin:ro" \
    -v "$REPO/gameserver_cpp/build/docker:/build" \
    -w /build \
    "$IMAGE" \
    bash -c "
        set -euo pipefail
        cmake -S /src -B /build \
            -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
            -DJX_WIN_SOURCE=/jxwin
        cmake --build /build --parallel --target $TARGET
    "

echo
echo "artifacts in gameserver_cpp/build/docker/"
