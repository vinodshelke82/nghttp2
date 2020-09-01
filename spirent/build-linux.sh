#!/bin/bash
#
# Builds nghttp2 64 bit.
# Prerequisites for build:
#   Install automake, autoconf and libtool based on latest requirements.
# Prerequisites:
# boost 1.64 ( same used by STC)
# openssl 1.0+ (same used by STC)

set -eo pipefail

# Build configure file
autoreconf -i
automake
autoconf

readonly RELEASE_64=release64
readonly DEBUG_64=debug64

# --------------------------------- BUILDING Linux 64 Release ----------------------------------

PREFIXDIR="$PWD/$RELEASE_64"
if [ ! -d "$PREFIXDIR" ]; then
  mkdir $PREFIXDIR
fi

LDFLAGS=-L/usr/gcc_4_9/lib64 CC=/usr/gcc_4_9/bin/gcc LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/gcc_7_2/lib  \
./configure --prefix=$PREFIXDIR &&\

CC=/usr/gcc_4_9/bin/gcc LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/gcc_7_2/lib make -j 4 &&\
make install
