#!/bin/sh
set -ex

export ONEFETCH_VERSION=v1.6.5

# install onefetch
wget -O /tmp/onefetch_linux_x86-64.zip https://github.com/o2sh/onefetch/releases/download/${ONEFETCH_VERSION}/onefetch_linux_x86-64.zip
mkdir -p ~/bin
unzip /tmp/onefetch_linux_x86-64.zip -d ~/bin
rm -f /tmp/onefetch_linux_x86-64.zip
