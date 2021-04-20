#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export GOSS_VERSION=0.3.16
export GOSS_INSTALL_PATH=~/.local
export GOSS_ROOT="$GOSS_INSTALL_PATH/goss"
export GOSS_PKG=goss-"$OS_TYPE"
export GOSS_URL=https://github.com/aelsabbahy/goss/releases
export GOSS_URL="$GOSS_URL/download/v$GOSS_VERSION/$GOSS_PKG"

# install goss
# https://github.com/aelsabbahy/goss

clean() {
    rm "/tmp/$GOSS_PKG.sha256" /tmp/goss.sum
}

download() {
    wget -O "/tmp/$GOSS_PKG" "$GOSS_URL"
    wget -O "/tmp/$GOSS_PKG".sha256 "$GOSS_URL".sha256
    echo "$(awk '{print $1}' "/tmp/$GOSS_PKG.sha256")" "/tmp/$GOSS_PKG" > /tmp/goss.sum
    sha256sum -c /tmp/goss.sum
}

install() {
    mkdir -p ~bin
    mv "/tmp/$GOSS_PKG" ~/bin/goss
    chmod +x ~/bin/goss
}

if [[ "$OS_TYPE" == "linux-amd64" ]]; then
    echo "This script will install goss language version $GOSS_VERSION."
    if [[ -s "$HOME/bin/goss" ]]; then
        read -p "$HOME/bin/goss already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            download
            install
            clean
        fi
    else
        download
        install
        clean
    fi
fi
