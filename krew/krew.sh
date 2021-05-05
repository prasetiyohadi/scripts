#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux-amd64
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=$OS_TYPE_LINUX_AMD64
APP_BIN=krew

main_linux() {
    APP_VERSION=latest
    echo "This script will install $APP_BIN version $APP_VERSION."
    which git > /dev/null && export GIT_EXISTS=0
    if [ "$GIT_EXISTS" == "0" ]; then
        set -x; cd "$(mktemp -d)"
        OS=$(uname | tr '[:upper:]' '[:lower:]')
        ARCH=$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')
        curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz"
        tar zxvf krew.tar.gz
        KREW=./krew-"${OS}_${ARCH}"
        "$KREW" install krew

        # update PATH
        KREW_ROOT="$HOME"
        PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
        kubectl-krew update
    fi
}

main_darwin() {
    APP_VERSION=latest
    echo "This script will install $APP_BIN version $APP_VERSION using brew."
    which brew > /dev/null && brew install $APP_BIN
}

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
        main_linux
    elif [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
        main_darwin
    fi
}

main
