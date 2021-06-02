#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_ID=""
[ -f "/etc/os-release" ] && source /etc/os-release && OS_ID=$ID
OS_TYPE=$(echo "${OS}" | tr -d ".[:digit:]")

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ ! -d ~/.pyenv ]; then
        # install prerequisites
        # https://github.com/pyenv/pyenv/wiki/Common-build-problems
        if [ "$OS_ID" == "debian" ] || [ "$OS_ID" == "ubuntu" ]; then
            sudo apt-get update
            sudo apt-get install --no-install-recommends --no-install-suggests \
                -y build-essential libssl-dev zlib1g-dev libbz2-dev \
                libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
                libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev \
                python-openssl git
        elif [ "$OS_ID" == "fedora" ]; then
            sudo dnf install make gcc zlib-devel bzip2 bzip2-devel \
                readline-devel sqlite sqlite-devel openssl-devel tk-devel \
                libffi-devel xz-devel

        elif [ "$OS_ID" == "centos" ]; then
            sudo yum install @development zlib-devel bzip2 bzip2-devel \
                readline-devel sqlite sqlite-devel openssl-devel xz xz-devel \
                libffi-devel findutils
        fi
        # install pyenv
        curl https://pyenv.run | bash
        exec $SHELL
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    # install pyenv and prerequisites
    which brew > /dev/null && brew install pyenv readline xz
fi
