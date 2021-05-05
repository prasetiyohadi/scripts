#!/usr/bin/env bash
set -euo pipefail

OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=mac64
OS_TYPE_LINUX_AMD64=linux-x86_64
OS_TYPE_LINUX_ARM=linux-armv7l
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE="$OS_TYPE_DARWIN"
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE="$OS_TYPE_LINUX_AMD64"
[ "$OS_TYPE" == "linux-gnueabihf" ] && export OS_TYPE="$OS_TYPE_LINUX_ARM"
APP_BIN=julia
APP_VERSION=1.6.1
APP_MAJOR_VERSION=1.6
APP_SRC="$APP_BIN-$APP_VERSION-$OS_TYPE"
APP_URL=https://julialang-s3.julialang.org/bin
[ "$OS_TYPE" == "$OS_TYPE_DARWIN" ] \
    && export APP_PKG="$APP_SRC.dmg" APP_URL="$APP_URL/mac/x64"
[ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ] \
    && export APP_PKG="$APP_SRC.tar.gz" APP_URL="$APP_URL/linux/x64"
[ "$OS_TYPE" == "$OS_TYPE_LINUX_ARM" ] \
    && export APP_PKG="$APP_SRC.tar.gz" APP_URL="$APP_URL/linux/armv7l"
APP_URL="$APP_URL/$APP_MAJOR_VERSION/$APP_PKG"
APP_INSTALL_PATH=~/.local
APP_ROOT_PATH=~/.local/julia

setup() {
    mkdir -p "$APP_INSTALL_PATH"
    wget -O - "$APP_URL" | tar -C "$APP_INSTALL_PATH" -zxf -
    mv "$APP_INSTALL_PATH/$APP_BIN-$APP_VERSION" \
        "$APP_INSTALL_PATH/$APP_BIN"
}

main_linux() {
    echo "This script will install $APP_BIN version $APP_VERSION."
    if [ -d "$APP_ROOT_PATH" ]; then
        read -p "$APP_ROOT_PATH already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            rm -rf "$APP_ROOT_PATH"
            setup
        else
            echo "Installation cancelled."
        fi
    else
        setup
    fi
}

main_darwin() {
    echo "This script will download $APP_BIN version $APP_VERSION."
    wget -O "$HOME/Downloads/$APP_PKG" "$APP_URL"
}

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ] \
        || [ "$OS_TYPE" == "$OS_TYPE_LINUX_ARM" ]; then
        main_linux
    elif [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
        main_darwin
    fi
}

main
