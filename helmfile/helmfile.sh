#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
export HELMFILE_VERSION=0.138.7
export HELMFILE_PKG=helmfile_"$OS_TYPE"
export HELMFILE_URL="https://github.com/roboll/helmfile/releases"
export HELMFILE_URL="$HELMFILE_URL/download/v$HELMFILE_VERSION/$HELMFILE_PKG"

# install helmfile
# https://github.com/roboll/helmfile

download() {
    wget -O "/tmp/$HELMFILE_PKG" "$HELMFILE_URL"
}

install() {
    mkdir -p ~/bin
    mv "/tmp/$HELMFILE_PKG" ~/bin/helmfile
    chmod +x ~/bin/helmfile
}

main() {
    download
    install
}

if [[ "$OS_TYPE" == "linux_amd64" ]]; then
    echo "This script will install helmfile version $HELMFILE_VERSION."
    if [[ -s $HOME/bin/helmfile ]]; then
        read -p "$HOME/bin/helmfile already exists. Replace[yn]? " -n 1 -r
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
    echo "This script will install helmfile version $HELMFILE_VERSION using brew."
    which brew > /dev/null && brew install helmfile
fi
