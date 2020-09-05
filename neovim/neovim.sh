#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ ! -d ~/.config/nvim ]; then
        if [ -f /etc/debian_version ]; then
            # remove vim
            sudo apt purge -y vim-tiny vim-runtime vim-common
            # install neovim
            sudo apt update
            sudo apt install -y neovim
        fi
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    if [ ! -d ~/.config/nvim ]; then
        # install neovim
        which brew > /dev/null && brew install neovim
    fi
fi

# install neovim configuration file
CWD=$(dirname $0)
mkdir -p ~/.config/nvim
cp $CWD/init.vim ~/.config/nvim/init.vim

# install plugins
nvim +PlugInstall +qall
