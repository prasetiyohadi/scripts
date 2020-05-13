#!/bin/sh
set -ex

# install tmux and powerline-status
sudo apt update
sudo apt install -y python3-pip tmux
pip3 install --user powerline-status

# install .zshrc
CWD=$(dirname $0)
cp $CWD/tmux.conf ~/.tmux.conf

# remove python3-pip
sudo apt purge -y python3-pip
sudo apt autoremove -y
