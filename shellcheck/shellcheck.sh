#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE

# install shellcheck
# https://github.com/koalaman/shellcheck
if [[ "$OS_TYPE" == "linux-gnu" ]]; then
    echo "This script will install shellcheck."
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install --assume-yes shellcheck
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install --assumeyes epel-release
        sudo dnf install --assumeyes shellcheck
    fi
elif [[ "$OS_TYPE" == "darwin" ]]; then
    echo "This script will install shellcheck."
    which brew > /dev/null && brew install shellcheck
fi
