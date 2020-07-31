#!/bin/bash
set -euxo pipefail

# remove vim
sudo apt purge vim-tiny vim-runtime vim-common -y

# install neovim
sudo apt update
sudo apt install -y neovim

# install neovim configuration file
CWD=$(dirname $0)
mkdir -p ~/.config/nvim
cp $CWD/init.vim ~/.config/nvim/init.vim

# install plugins
nvim +PlugInstall
