#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        # install tmux and powerline
        sudo apt-get update
        sudo apt-get install -y powerline tmux
    fi
fi

# install .zshrc
CWD=$(dirname $0)
cp $CWD/tmux.conf ~/.tmux.conf
