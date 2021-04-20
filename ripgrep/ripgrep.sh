#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE

# install ripgrep
# https://github.com/BurntSushi/ripgrep
install() {
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install --assume-yes ripgrep
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install --assumeyes epel-release
        sudo dnf install --assumeyes ripgrep
    fi
}

main() {
    install
}

if [[ "$OS_TYPE" == "linux-gnu" ]]; then
    echo "This script will install ripgrep."
    main
elif [[ "$OS_TYPE" == "darwin" ]]; then
    echo "This script will install ripgrep."
    which brew > /dev/null && brew install ripgrep
fi
