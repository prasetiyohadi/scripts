#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=darwin_amd64
OS_TYPE_LINUX_AMD64=linux_amd64
OS_TYPE_LINUX_ARM=linux_arm
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE="$OS_TYPE_DARWIN"
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE="$OS_TYPE_LINUX_AMD64"
[ "$OS_TYPE" == "linux-gnueabihf" ] && export OS_TYPE="$OS_TYPE_LINUX_ARM"
APP_BIN=nomad
APP_VERSION=1.1.0
APP_SRC=${APP_BIN}_${APP_VERSION}_${OS_TYPE}
APP_PKG=$APP_SRC.zip
APP_URL=https://releases.hashicorp.com/$APP_BIN/$APP_VERSION
APP_URL=$APP_URL/$APP_PKG

# install nomad
# https://www.nomadproject.io/downloads
clean() {
    rm -f /tmp/${APP_PKG}
}

download() {
    wget -O /tmp/${APP_PKG} ${APP_URL}
}

install() {
    mkdir -p ~/bin
    unzip /tmp/${APP_PKG} -d ~/bin
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
    echo "This script will install $APP_BIN version $APP_VERSION using brew."
    which brew > /dev/null && brew install $APP_BIN
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
