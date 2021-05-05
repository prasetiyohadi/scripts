#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
APP_VERSION=3.0.73
OS_TYPE_DARWIN="macosx-$APP_VERSION-amd64"
OS_TYPE_LINUX_AMD64="linux-$APP_VERSION-amd64"
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE=$OS_TYPE_DARWIN
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=$OS_TYPE_LINUX_AMD64
APP_BIN=aliyun
APP_SRC="$APP_BIN-cli-$OS_TYPE"
APP_PKG="$APP_SRC.tgz"
APP_URL="https://aliyuncli.alicdn.com/$APP_PKG"

# install aliyun CLI
# https://github.com/aliyun/aliyun-cli
clean() {
    rm -f "/tmp/$APP_PKG"
}

download() {
    wget -O "/tmp/$APP_PKG" "$APP_URL"
}

install() {
    mkdir -p ~/bin
    tar -xf "/tmp/$APP_PKG" -C ~/bin
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
    which brew > /dev/null && brew install $APP_BIN
}

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
        main_linux
    elif [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
        main_darwin
    fi
}

main
