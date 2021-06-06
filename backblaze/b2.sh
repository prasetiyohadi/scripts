#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=$OS_TYPE_LINUX_AMD64
APP_BIN=b2
APP_VERSION=2.5.0
APP_SRC="$APP_BIN-$OS_TYPE"
APP_URL=https://github.com/Backblaze/B2_Command_Line_Tool/releases
APP_URL="$APP_URL/download/v$APP_VERSION/$APP_SRC"

setup() {
    curl --create-dirs -L -o "$HOME/bin/$APP_BIN" $APP_URL
    chmod +x "$HOME/bin/$APP_BIN"
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
    which brew > /dev/null && brew install $APP_BIN-tools
}

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
        main_linux
    elif [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
        main_darwin
    fi
}

main
