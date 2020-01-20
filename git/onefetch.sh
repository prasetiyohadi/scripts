#!/bin/sh
set -ex

export OS=${OSTYPE:-'linux'}
export OS_TYPE=linux
export ONEFETCH_VERSION=v2.2.0
export ONEFETCH_URL=https://github.com/o2sh/onefetch/releases/download/${ONEFETCH_VERSION}/onefetch_${OS_TYPE}_x86-64.zip

# install onefetch
wget -O /tmp/onefetch_${OS_TYPE}_x86-64.zip https://github.com/o2sh/onefetch/releases/download/${ONEFETCH_VERSION}/onefetch_${OS_TYPE}_x86-64.zip
mkdir -p ~/bin
unzip /tmp/onefetch_${OS_TYPE}_x86-64.zip -d ~/bin
rm -f /tmp/onefetch_${OS_TYPE}_x86-64.zip
