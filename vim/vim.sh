#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        # install vim-nox
        sudo apt update
        sudo apt install -y python3-neovim python3-pynvim vim-nox
    fi
fi

if [ -f "~/.vimrc" ]; then
    # install .vimrc
    CWD=$(dirname $0)
    cp $CWD/vimrc ~/.vimrc
else
    echo "~/.vimrc file already exists!"
fi

if [ -d "~/.vim" ]; then
    # install vim packages
    mkdir -p ~/.vim/pack/plugins/start
    git clone https://github.com/Shougo/deoplete.nvim \
      ~/.vim/pack/plugins/start/deoplete
    git clone https://github.com/scrooloose/nerdtree.git \
      ~/.vim/pack/plugins/start/nerdtree
    git clone https://github.com/roxma/nvim-yarp \
      ~/.vim/pack/plugins/start/nvim-yarp
    git clone https://github.com/vim-airline/vim-airline \
      ~/.vim/pack/plugins/start/vim-airline
    git clone https://github.com/vim-airline/vim-airline-themes \
      ~/.vim/pack/plugins/start/vim-airline-themes
    git clone https://github.com/tpope/vim-fugitive.git \
      ~/.vim/pack/plugins/start/vim-fugitive
    git clone https://github.com/airblade/vim-gitgutter.git \
      ~/.vim/pack/plugins/start/vim-gitgutter
    git clone https://github.com/fatih/vim-go.git \
      ~/.vim/pack/plugins/start/vim-go
    git clone https://github.com/roxma/vim-hug-neovim-rpc \
      ~/.vim/pack/plugins/start/vim-hug-neovim-rpc
    git clone https://github.com/tpope/vim-sensible.git \
      ~/.vim/pack/plugins/start/vim-sensible
    git clone https://github.com/jmcantrell/vim-virtualenv.git \
      ~/.vim/pack/plugins/start/vim-virtualenv
else
    echo "~/.vim directory already exitst!"
fi

# do not forget to run :helptags ~/.vim/pack/plugins/start/vim-airline/doc
