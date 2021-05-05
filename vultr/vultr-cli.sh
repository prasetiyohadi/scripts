#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_64-bit
export VULTR_CLI_VERSION=2.4.1
export VULTR_CLI_SRC=vultr-cli_"$VULTR_CLI_VERSION"_"$OS_TYPE"
export VULTR_CLI_PKG="$VULTR_CLI_SRC.tar.gz"
export VULTR_CLI_URL="https://github.com/vultr/vultr-cli/releases"
export VULTR_CLI_URL="$VULTR_CLI_URL/download/v$VULTR_CLI_VERSION/$VULTR_CLI_PKG"

# install vultr-cli
# https://www.vultr.com/news/How-to-Easily-Manage-Instances-with-Vultr-CLI/

clean() {
    rm -r "/tmp/$VULTR_CLI_PKG" "/tmp/$VULTR_CLI_SRC"
}

download() {
    wget -O "/tmp/$VULTR_CLI_PKG" "$VULTR_CLI_URL"
    mkdir -p "/tmp/$VULTR_CLI_SRC"
    tar -xf "/tmp/$VULTR_CLI_PKG" -C "/tmp/$VULTR_CLI_SRC"
}

install() {
    mkdir -p ~/bin
    mv "/tmp/$VULTR_CLI_SRC/vultr-cli" ~/bin
}

setup() {
    download
    install
    clean
}

main_linux() {
    echo "This script will install vultr-cli version $VULTR_CLI_VERSION."
    if [[ -s "$HOME/bin/vultr-cli" ]]; then
        read -p "$HOME/bin/vultr-cli already exists. Replace[yn]? " -n 1 -r
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
    echo "This script will install vultr-cli version $VULTR_CLI_VERSION using brew."
    which brew > /dev/null && brew tap vultr/vultr-cli
    brew install vultr-cli
}

main() {
    if [[ "$OS_TYPE" == "linux_64-bit" ]]; then
        main_linux
    elif [[ "$OS_TYPE" == "darwin" ]]; then
        main_darwin
    fi
}

main
