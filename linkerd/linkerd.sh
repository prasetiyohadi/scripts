#!/usr/bin/env bash
set -euo pipefail

OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux-gnu
OS_TYPE_LINUX_ARM=linux-gnueabihf
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE="$OS_TYPE_DARWIN"
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE="$OS_TYPE_LINUX_AMD64"
[ "$OS_TYPE" == "linux-gnueabihf" ] && export OS_TYPE="$OS_TYPE_LINUX_ARM"
APP_BIN=linkerd
APP_VERSION=2.10

main_linux() {
    echo "This script will install $APP_BIN version $APP_VERSION."
    curl -sL run.linkerd.io/install | sh
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
