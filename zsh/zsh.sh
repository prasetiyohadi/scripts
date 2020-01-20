#!/bin/sh
set -ex

# install .zshrc
CWD=$(dirname $0)
cp $CWD/zshrc ~/.zshrc

# install oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# install oh-my-zsh custom plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# install oh-my-zsh custom themes
cp $CWD/catalyst.zsh-theme ~/.oh-my-zsh/custom/themes/catalyst.zsh-theme
