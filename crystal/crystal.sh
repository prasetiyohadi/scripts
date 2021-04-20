#!/usr/bin/env bash
set -euo pipefail

export OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE="$(echo "$OS" | tr -d ".[:digit:]")"
export OS_TYPE

# install crystal-lang
# https://crystal-lang.org/install/
if [[ "$OS_TYPE" == "linux-gnu" ]]; then
    echo "This script will install crystal-lang."
    if [ -f /etc/debian_version ]; then
        curl -fsSL https://crystal-lang.org/install.sh | sudo bash
        sudo apt install libssl-dev libxml2-dev libyaml-dev libgmp-dev libz-dev
    elif [ -f /etc/redhat-release ]; then
        curl -fsSL https://crystal-lang.org/install.sh | sudo bash
    fi
elif [[ "$OS_TYPE" == "darwin" ]]; then
    echo "This script will install crystal-lang."
    which brew > /dev/null && brew install crystal
fi
