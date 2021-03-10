#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
export VIM_PLUG_LOCATION=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
export VIM_PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ ! -d ~/.config/nvim ]; then
        if [ -f /etc/debian_version ]; then
            # remove vim
            sudo apt-get purge -y vim-tiny vim-runtime vim-common
            # install neovim
            sudo apt-get update
            sudo apt-get install -y neovim
        fi
        # install vim-plug
        # https://github.com/junegunn/vim-plug
        sh -c 'curl -fLo ${VIM_PLUG_LOCATION} --create-dirs ${VIM_PLUG_URL}'
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    if [ ! -d ~/.config/nvim ]; then
        # install neovim
        which brew > /dev/null && brew install neovim
        # install vim-plug
        # https://github.com/junegunn/vim-plug
        sh -c 'curl -fLo ${VIM_PLUG_LOCATION} --create-dirs ${VIM_PLUG_URL}'
    fi
fi

# install neovim configuration file
CWD=$(dirname $0)
mkdir -p ~/.config/nvim
cp $CWD/init.vim ~/.config/nvim/init.vim

# install plugins
nvim +PlugInstall +qall
