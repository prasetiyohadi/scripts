#!/bin/sh
set -ex

sudo apt update
sudo apt install python3-pip tmux
pip3 install --user powerline-status
cp tmux.conf ~/.tmux.conf
sudo apt purge python3-pip
sudo apt autoremove
