#!/bin/sh
set -ex

# install .vimrc
CWD=$(dirname $0)
cp $CWD/vimrc ~/.vimrc

# install vim packages
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/scrooloose/nerdtree.git \
  ~/.vim/pack/plugins/start/nerdtree
git clone https://github.com/vim-airline/vim-airline \
  ~/.vim/pack/plugins/start/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes \
  ~/.vim/pack/plugins/start/vim-airline-themes
git clone https://github.com/tpope/vim-fugitive.git \
  ~/.vim/pack/plugins/start/vim-fugitive
git clone https://github.com/airblade/vim-gitgutter.git \
  ~/.vim/pack/plugins/start/vim-gitgutter
git clone https://github.com/tpope/vim-sensible.git \
  ~/.vim/pack/plugins/start/vim-sensible
git clone https://github.com/jmcantrell/vim-virtualenv.git \
  ~/.vim/pack/plugins/start/vim-virtualenv

# do not forget to run :helptags ~/.vim/pack/plugins/start/vim-airline/doc
