#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        # install tmux and powerline
        sudo apt-get update
        sudo apt-get install -y powerline tmux
    elif [ -f /etc/redhat-release ]; then
        # install tmux and powerline
        sudo dnf install --assumeyes python3-pip tmux
        sudo pip3 install powerline-status
    fi
elif [ "${OS_TYPE}" == "linux-gnueabihf" ]; then
    if [ -f /etc/debian_version ]; then
        # install tmux and powerline
        sudo apt-get update
        sudo apt-get install -y powerline tmux
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    # install powerline, python, and tmux
    which brew > /dev/null && brew install python tmux
    pip3 install powerline-status psutil
fi

# install .zshrc
CWD=$(dirname $0)
cp $CWD/tmux.conf ~/.tmux.conf
