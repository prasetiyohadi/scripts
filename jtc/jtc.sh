#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE=macos
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=linux
export JTC_VERSION=1.76
export JTC_URL=https://github.com/ldn-softdev/jtc/releases/download

# install jtc
# https://github.com/ldn-softdev/jtc
mkdir -p ~/bin
wget -O ~/bin/jtc ${JTC_URL}/${JTC_VERSION}/jtc-${OS_TYPE}-64.v${JTC_VERSION}
chmod +x ~/bin/jtc
