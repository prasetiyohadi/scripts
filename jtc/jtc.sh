#!/bin/sh
set -ex

export JTC_VERSION=1.74

# install jtc
mkdir -p ~/bin
wget -O ~/bin/jtc https://github.com/ldn-softdev/jtc/releases/download/${JTC_VERSION}/jtc-linux-64.v${JTC_VERSION}
chmod +x ~/bin/jtc
