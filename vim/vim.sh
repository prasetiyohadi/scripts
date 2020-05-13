#!/bin/sh
set -ex

# install vim-nox
sudo apt update
sudo apt install -y python3-pip vim-nox
pip3 install --user neovim pynvim

# install .vimrc
CWD=$(dirname $0)
cp $CWD/vimrc ~/.vimrc

# remove python3-pip
sudo apt purge -y python3-pip
sudo apt autoremove -y

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

# do not forget to run :helptags ~/.vim/pack/plugins/start/vim-airline/doc
