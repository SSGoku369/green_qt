#!/bin/bash
set -eo pipefail

if [ -f /.dockerenv ]; then
    if [ -f /buster_hash ]; then
        buster_deps_sha256=$(< /buster_hash)
        echo "${buster_deps_sha256} tools/buster_deps.sh" | sha256sum --check --strict --status && exit 0 || true
    fi
fi

apt update -yqq
apt upgrade --no-install-recommends -yqq
apt install --no-install-recommends -yqq clang curl ca-certificates unzip git automake autoconf pkg-config libtool build-essential ninja-build llvm-dev python3-pip python3-setuptools virtualenv libgl1-mesa-dev python g++-mingw-w64-x86-64 libfontconfig1-dev libfreetype6-dev libx11-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libx11-xcb-dev libxcb-glx0-dev libxkbcommon-x11-dev

if [ ! -d /qt-everywhere-src-5.13.1 ]; then
   curl -sL -o qt-everywhere-src-5.13.1.tar.xz https://download.qt.io/archive/qt/5.13/5.13.1/single/qt-everywhere-src-5.13.1.tar.xz
   echo "adf00266dc38352a166a9739f1a24a1e36f1be9c04bf72e16e142a256436974e qt-everywhere-src-5.13.1.tar.xz" | sha256sum --check --strict
   tar xf qt-everywhere-src-5.13.1.tar.xz
   rm qt-everywhere-src-5.13.1.tar.xz
fi

if [ -f /.dockerenv ]; then
    sha256sum /buster_deps.sh | cut -d" " -f1 > /buster_hash
    apt -yqq autoremove
    apt -yqq clean
    rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /usr/share/locale/* /usr/share/man /usr/share/doc /lib/xtables/libip6* /root/.cache
fi