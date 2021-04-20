#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=Linux_x86_64
export CONFTEST_VERSION=0.23.0
export CONFTEST_SRC=conftest_"$CONFTEST_VERSION"_"$OS_TYPE"
export CONFTEST_PKG="$CONFTEST_SRC.tar.gz"
export CONFTEST_URL="https://github.com/open-policy-agent/conftest/releases"
export CONFTEST_URL="$CONFTEST_URL/download/v$CONFTEST_VERSION/$CONFTEST_PKG"

# install conftest
# https://www.conftest.dev/install/

clean() {
    rm -r "/tmp/$CONFTEST_PKG" "/tmp/$CONFTEST_SRC"
}

download() {
    wget -O "/tmp/$CONFTEST_PKG" "$CONFTEST_URL"
    mkdir -p "/tmp/$CONFTEST_SRC"
    tar -xf "/tmp/$CONFTEST_PKG" -C "/tmp/$CONFTEST_SRC"
}

install() {
    mkdir -p ~/bin
    mv "/tmp/$CONFTEST_SRC/conftest" ~/bin
}

main() {
    download
    install
    clean
}

if [[ "$OS_TYPE" == "Linux_x86_64" ]]; then
    echo "This script will install conftest version $CONFTEST_VERSION."
    if [[ -s "$HOME/bin/conftest" ]]; then
        read -p "$HOME/bin/conftest already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            main
        else
            echo "Installation cancelled."
        fi
    else
        main
    fi
elif [[ "$OS_TYPE" == "darwin" ]]; then
    echo "This script will install conftest version $CONFTEST_VERSION using brew."
    which brew > /dev/null && brew tap instrumenta/instrumenta
    brew install conftest
fi
