#!/bin/bash
set -euxo pipefail

# install .zshrc
CWD=$(dirname $0)
if [ -f /etc/debian_version ]; then
  cp $CWD/zshrc.debian ~/.zshrc
fi

# install oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
  (cd ~/.oh-my-zsh && git pull)
else
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

# install oh-my-zsh custom plugins
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
  (cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull)
else
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  (cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull)
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# install oh-my-zsh custom themes
cp $CWD/catalyst.zsh-theme ~/.oh-my-zsh/custom/themes/catalyst.zsh-theme
