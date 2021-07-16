#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux-amd64
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=$OS_TYPE_LINUX_AMD64
APP_BIN=rclone
APP_VERSION=1.55.1
APP_SRC=$APP_BIN-v$APP_VERSION-$OS_TYPE
APP_PATH=~/bin/$APP_BIN
APP_PKG=$APP_SRC.zip
APP_URL=https://downloads.rclone.org/v$APP_VERSION/$APP_PKG

check_version() {
    $APP_BIN version
}

clean() {
    rm -fr /tmp/$APP_PKG /tmp/$APP_SRC
}

download() {
    wget -O /tmp/$APP_PKG $APP_URL
}

install() {
    mkdir -p ~/bin
    unzip -d /tmp /tmp/$APP_PKG
    mv /tmp/$APP_SRC/rclone ~/bin
}

install_linux() {
    download
    install
    clean
}

setup_darwin() {
    echo "This script will install $APP_BIN using brew."
    command -v brew > /dev/null && brew install $APP_BIN
}

setup_linux() {
    echo "This script will install $APP_BIN version $APP_VERSION."
    if [ -s "$APP_PATH" ]; then
        check_version
        read -p "$APP_PATH already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            install_linux
        else
            echo "Installation cancelled."
        fi
    else
        install_linux
    fi
}

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
        setup_linux
    elif [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
        setup_darwin
    fi
}

main
