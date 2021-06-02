#!/usr/bin/env bash
set -euo pipefail

OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_LINUX_AMD64=amd64
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE="$OS_TYPE_LINUX_AMD64"
APP_BIN=docker-credential-pass
APP_VERSION=0.6.3
APP_SRC="$APP_BIN-v$APP_VERSION-$OS_TYPE"
APP_PKG="$APP_SRC.tar.gz"
APP_URL="https://github.com/docker/docker-credential-helpers/releases/download"
APP_URL="$APP_URL/v$APP_VERSION/$APP_PKG"
APP_INSTALL_PATH="/usr/local/bin"

setup() {
    if [ -f /etc/redhat-release ]; then
        # install pass
        sudo dnf install --assumeyes pass
    fi
    mkdir -p "$APP_INSTALL_PATH"
    wget -O - "$APP_URL" | sudo tar -C "$APP_INSTALL_PATH" -zxf -
    sudo chmod +x "$APP_INSTALL_PATH/$APP_BIN"
}

main_linux() {
    echo "This script will install $APP_BIN version $APP_VERSION."
    if [ -s "$APP_INSTALL_PATH/$APP_BIN" ]; then
        read -p "$APP_INSTALL_PATH/$APP_BIN already exists. Replace[yn]? " -n 1 -r
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

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
        main_linux
    fi
}

main
