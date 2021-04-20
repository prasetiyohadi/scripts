#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
export CLOUDNUKE_VERSION=0.1.28
export CLOUDNUKE_PKG=cloud-nuke_"$OS_TYPE"
export CLOUDNUKE_URL="https://github.com/gruntwork-io/cloud-nuke/releases"
export CLOUDNUKE_URL="$CLOUDNUKE_URL/download/v$CLOUDNUKE_VERSION/$CLOUDNUKE_PKG"

# install cloud-nuke
# https://github.com/gruntwork-io/cloud-nuke

download() {
    wget -O "/tmp/$CLOUDNUKE_PKG" "$CLOUDNUKE_URL"
}

install() {
    mkdir -p ~/bin
    mv "/tmp/$CLOUDNUKE_PKG" ~/bin/cloud-nuke
    chmod +x ~/bin/cloud-nuke
}

main() {
    download
    install
}

if [[ "$OS_TYPE" == "linux_amd64" ]]; then
    echo "This script will install cloud-nuke version $CLOUDNUKE_VERSION."
    if [[ -s $HOME/bin/cloud-nuke ]]; then
        read -p "$HOME/bin/cloud-nuke already exists. Replace[yn]? " -n 1 -r
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
    echo "This script will install cloud-nuke version $CLOUDNUKE_VERSION using brew."
    which brew > /dev/null && brew install cloud-nuke
fi
