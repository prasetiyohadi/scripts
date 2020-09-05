#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE=macos
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=linux
export ONEFETCH_VERSION=v2.2.0
if [ "$OS_TYPE" == "linux"]; then
    export ONEFETCH_URL=https://github.com/o2sh/onefetch/releases/download/${ONEFETCH_VERSION}/onefetch_${OS_TYPE}_x86-64.zip
elif [ "$OS_TYPE" == "macos"]; then
    export ONEFETCH_URL=https://github.com/o2sh/onefetch/releases/download/${ONEFETCH_VERSION}/onefetch_${ONEFETCH_VERSION}_${OS_TYPE}_x86-64.zip
fi

# install onefetch
# https://github.com/o2sh/onefetch
wget -O /tmp/onefetch_${OS_TYPE}_x86-64.zip https://github.com/o2sh/onefetch/releases/download/${ONEFETCH_VERSION}/onefetch_${OS_TYPE}_x86-64.zip
mkdir -p ~/bin
unzip /tmp/onefetch_${OS_TYPE}_x86-64.zip -d ~/bin
rm -f /tmp/onefetch_${OS_TYPE}_x86-64.zip
