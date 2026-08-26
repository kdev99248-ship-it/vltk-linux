# Build toolchain for the gameserver port. Deliberately contains NO source:
# the Windows tree lives outside this repo (E:/jx/Source/...), so baking it in
# would mean a multi-gigabyte build context and a rebuild on every edit. Mount
# both trees at run time instead -- see docker/gameserver-build/build.sh.
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# -m32 is a hard requirement, not a preference: libheaven.so and librainbow.so
# ship as ELF32 i386. That is what pulls in the multilib packages -- plain g++
# cannot produce a binary able to load them.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        cmake \
        make \
        g++ \
        g++-multilib \
        gcc-multilib \
        libc6-dev-i386 \
        lib32stdc++-13-dev \
        lib32asan8 \
        lib32ubsan1 \
        python3 \
        file \
        binutils \
    && rm -rf /var/lib/apt/lists/*

# Prove multilib works now rather than discovering it mid-build. If this line
# fails the image is broken and no amount of CMake debugging will help.
RUN printf 'int main(void){return 0;}\n' > /tmp/m32.c \
    && gcc -m32 /tmp/m32.c -o /tmp/m32 \
    && file /tmp/m32 | grep -q 'ELF 32-bit' \
    && rm -f /tmp/m32.c /tmp/m32

WORKDIR /work
CMD ["/bin/bash"]
