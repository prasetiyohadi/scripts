#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
export OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_x64
export NIM_VERSION=1.4.4
export NIM_INSTALL_PATH=~/.local
export NIM_ROOT="$NIM_INSTALL_PATH/nim"
export NIM_SRC=nim-"$NIM_VERSION-$OS_TYPE"
export NIM_PKG="$NIM_SRC.tar.xz"
export NIM_URL="https://nim-lang.org/download/$NIM_PKG"

# install nim
# https://nim-lang.org/install_unix.html

clean() {
    rm "/tmp/$NIM_PKG" "/tmp/$NIM_PKG.sha256" /tmp/nim.sum
}

download() {
    wget -O "/tmp/$NIM_PKG" "$NIM_URL"
    wget -O "/tmp/$NIM_PKG".sha256 "$NIM_URL".sha256
    echo "$(cat "/tmp/$NIM_PKG.sha256"|awk {'print $1'})" "/tmp/$NIM_PKG" > /tmp/nim.sum
    sha256sum -c /tmp/nim.sum
    tar -xf "/tmp/$NIM_PKG" -C /tmp
    mkdir -p "$NIM_INSTALL_PATH"
}

if [[ "$OS_TYPE" == "linux_x64" ]]; then
    echo "This script will install Nim language version $NIM_VERSION to $NIM_ROOT."
    if [[ -d "$NIM_ROOT" ]]; then
        read -p "$NIM_ROOT already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            download
            rm -r "$NIM_ROOT"
            mv "/tmp/nim-$NIM_VERSION" "$NIM_ROOT"
            clean
        fi
    else
        download
        mv "/tmp/nim-$NIM_VERSION" "$NIM_ROOT"
        clean
    fi
elif [[ "$OS_TYPE" == "darwin" ]]; then
    echo "This script will install Nim language version $NIM_VERSION using brew."
    which brew > /dev/null && brew install nim
fi
