#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=Linux-x86_64
export HADOLINT_VERSION=2.1.0
export HADOLINT_PKG=hadolint-"$OS_TYPE"
export HADOLINT_URL="https://github.com/hadolint/hadolint/releases"
export HADOLINT_URL="$HADOLINT_URL/download/v$HADOLINT_VERSION/$HADOLINT_PKG"

# install hadolint
# https://www.hadolint.dev/install/

download() {
    wget -O "/tmp/$HADOLINT_PKG" "$HADOLINT_URL"
}

install() {
    mkdir -p ~/bin
    mv "/tmp/$HADOLINT_PKG" ~/bin/hadolint
    chmod +x ~/bin/hadolint
}

main() {
    download
    install
}

if [[ "$OS_TYPE" == "Linux-x86_64" ]]; then
    echo "This script will install hadolint version $HADOLINT_VERSION."
    if [[ -s $HOME/bin/hadolint ]]; then
        read -p "$HOME/bin/hadolint already exists. Replace[yn]? " -n 1 -r
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
    echo "This script will install hadolint version $HADOLINT_VERSION using brew."
    which brew > /dev/null && brew install hadolint
fi
