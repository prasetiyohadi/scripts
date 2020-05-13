#!/bin/sh
set -ex

sudo apt update
sudo apt install openvpn
if [ -d ~/openvpn ]; then
  sudo mv -f /etc/openvpn{,.orig}
  sudo ln -s ~/openvpn /etc/openvpn
  sudo systemctl disable systemd-ask-password-wall.path systemd-ask-password-wall.service
  sudo systemctl stop systemd-ask-password-wall.path systemd-ask-password-wall.service
fi
