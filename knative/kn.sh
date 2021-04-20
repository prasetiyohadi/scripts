#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export KN_VERSION=0.22.0
export KN_PKG=kn-"$OS_TYPE"
export KN_URL=https://github.com/knative/client/releases
export KN_URL="$KN_URL/download/v$KN_VERSION/$KN_PKG"

# install knative client
# https://github.com/knative/client

download() {
    wget -O "/tmp/$KN_PKG" "$KN_URL"
}

install() {
    mkdir -p ~bin
    mv "/tmp/$KN_PKG" ~/bin/kn
    chmod +x ~/bin/kn
}

main() {
    download
    install
}

if [[ "$OS_TYPE" == "linux-amd64" ]]; then
    echo "This script will install knative client version $KN_VERSION."
    if [[ -s "$HOME/bin/kn" ]]; then
        read -p "$HOME/bin/kn already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            main
        fi
    else
        main
    fi
elif [[ "$OS_TYPE" == "darwin" ]]; then
    echo "This script will install knative client version $KN_VERSION using brew."
    which brew > /dev/null && brew install kn
fi
