#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_LINUX_AMD64=linux-amd64
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=$OS_TYPE_LINUX_AMD64
APP_BIN=goss
APP_URL=https://github.com/aelsabbahy/goss/releases/download
APP_VERSION=0.3.16
APP_PATH=~/bin/$APP_BIN
APP_SRC=$APP_BIN-$OS_TYPE
APP_URL=$APP_URL/v$APP_VERSION/$APP_SRC

check_version() {
    $APP_BIN --version
}

clean() {
    rm /tmp/$APP_SRC.sha256 /tmp/$APP_BIN.sum
}

download() {
    wget -O /tmp/$APP_SRC $APP_URL
    wget -O /tmp/$APP_SRC.sha256 $APP_URL.sha256
    echo "$(awk '{print $1}' /tmp/$APP_SRC.sha256)" /tmp/$APP_SRC > /tmp/$APP_BIN.sum
    sha256sum -c /tmp/$APP_BIN.sum
}

install() {
    mkdir -p ~bin
    mv /tmp/$APP_SRC $APP_PATH
    chmod +x $APP_PATH
}

install_linux() {
    download
    install
    clean
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
    fi
}

main
