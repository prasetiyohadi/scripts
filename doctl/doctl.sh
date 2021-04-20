#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export DOCTL_VERSION=1.59.0
export DOCTL_SRC=doctl-"$DOCTL_VERSION"-"$OS_TYPE"
export DOCTL_PKG="$DOCTL_SRC.tar.gz"
export DOCTL_URL="https://github.com/digitalocean/doctl/releases"
export DOCTL_URL="$DOCTL_URL/download/v$DOCTL_VERSION/$DOCTL_PKG"

# install doctl
# https://docs.digitalocean.com/reference/doctl/how-to/install/

clean() {
    rm -r "/tmp/$DOCTL_PKG" "/tmp/$DOCTL_SRC"
}

download() {
    wget -O "/tmp/$DOCTL_PKG" "$DOCTL_URL"
    mkdir -p "/tmp/$DOCTL_SRC"
    tar -xf "/tmp/$DOCTL_PKG" -C "/tmp/$DOCTL_SRC"
}

install() {
    mkdir -p ~/bin
    mv "/tmp/$DOCTL_SRC/doctl" ~/bin
}

main() {
    download
    install
    clean
}

if [[ "$OS_TYPE" == "linux-amd64" ]]; then
    echo "This script will install doctl version $DOCTL_VERSION."
    if [[ -s "$HOME/bin/doctl" ]]; then
        read -p "$HOME/bin/doctl already exists. Replace[yn]? " -n 1 -r
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
    echo "This script will install doctl version $DOCTL_VERSION using brew."
    which brew > /dev/null && brew install doctl
fi
