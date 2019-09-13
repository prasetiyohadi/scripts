#!/bin/bash
set -ex

sudo apt update
sudo apt install openvpn
sudo mv -f /etc/openvpn{,.orig}
sudo ln -s ~/openvpn /etc/openvpn
