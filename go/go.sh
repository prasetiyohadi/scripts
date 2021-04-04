#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
export OS_TYPE="$(echo "$OS" | tr -d "[:digit:]")"
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin-amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux-armv6l
export GO_VERSION="${GO_VERSION:-$(curl -s https://golang.org/VERSION?m=text)}"
export GO_INSTALL_PATH=~/.local
export GO_URL="https://dl.google.com/go/$GO_VERSION.$OS_TYPE.tar.gz"
export GOPATH=~/go
export GOROOT=~/.local/go

echo "This script will install Go language version $GO_VERSION to $GOROOT."

# install go
# https://golang.org/dl/

install() {
    mkdir -p "$GO_INSTALL_PATH" "$GOPATH"
    wget -O - "$GO_URL" | tar -C "$GO_INSTALL_PATH" -zxf -
}

if [[ "$OS_TYPE" == "linux-amd64" ]]; then
    if [[ -d "$GOROOT" ]]; then
        read -p "$GOROOT already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            rm -r "$GOROOT"
            install
        fi
    else
        install
    fi
fi
