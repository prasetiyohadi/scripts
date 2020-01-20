#!/bin/sh
set -ex

export OS=${OSTYPE:-'linux'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE=macos
export JTC_VERSION=1.75c
export JTC_URL=https://github.com/ldn-softdev/jtc/releases/download

# install jtc
mkdir -p ~/bin
wget -O ~/bin/jtc ${JTC_URL}/${JTC_VERSION}/jtc-${OS_TYPE}-64.v${JTC_VERSION}
chmod +x ~/bin/jtc
