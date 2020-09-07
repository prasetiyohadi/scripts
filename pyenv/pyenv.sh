#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ ! -d ~/.pyenv ]; then
        # install prerequisites
        # https://github.com/pyenv/pyenv/wiki/Common-build-problems
        if [ -f /etc/debian_version ]; then
            sudo apt-get update
            sudo apt-get install --no-install-recommends --no-install-suggests \
                -y build-essential libssl-dev zlib1g-dev libbz2-dev \
                libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
                libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev \
                python-openssl git
        fi
        # install pyenv
        curl https://pyenv.run | bash
        exec $SHELL
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    # install pyenv and prerequisites
    which brew > /dev/null && brew install pyenv readline xz
fi
