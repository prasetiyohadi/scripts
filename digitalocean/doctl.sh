#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux-amd64
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE="$OS_TYPE_LINUX_AMD64"
APP_BIN=doctl
APP_VERSION=1.59.0
APP_SRC="$APP_BIN-$APP_VERSION-$OS_TYPE"
APP_PKG="$APP_SRC.tar.gz"
APP_URL="https://github.com/digitalocean/doctl/releases"
APP_URL="$APP_URL/download/v$APP_VERSION/$APP_PKG"

clean() {
    rm -r "/tmp/$APP_PKG" "/tmp/$APP_SRC"
}

download() {
    wget -O "/tmp/$APP_PKG" "$APP_URL"
    mkdir -p "/tmp/$APP_SRC"
    tar -xf "/tmp/$APP_PKG" -C "/tmp/$APP_SRC"
}

install() {
    mkdir -p ~/bin
    mv "/tmp/$APP_SRC/$APP_BIN" ~/bin
}

setup() {
    download
    install
    clean
}

main_linux() {
    echo "This script will install $APP_BIN version $APP_VERSION."
    if [ -s "$HOME/bin/$APP_BIN" ]; then
        read -p "$HOME/bin/$APP_BIN already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            setup
        else
            echo "Installation cancelled."
        fi
    else
        setup
    fi
}

main_darwin() {
    APP_VERSION=latest
    echo "This script will install $APP_BIN version $APP_VERSION using brew."
    which brew > /dev/null && brew install "$APP_BIN"
}

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
        main_linux
    elif [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
        main_darwin
    fi
}

main
