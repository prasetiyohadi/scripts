#!/bin/sh
set -ex

export OS=${OSTYPE:-'linux'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE=macosx
export ALIYUN_CLI_VERSION=3.0.32
export ALIYUN_CLI_URL=https://github.com/aliyun/aliyun-cli/releases/download

if [ ! -f "/tmp/aliyun-cli-${OS_TYPE}-${ALIYUN_CLI_VERSION}-amd64.tgz" ]; then
  wget -O /tmp/aliyun-cli-${OS_TYPE}-${ALIYUN_CLI_VERSION}-amd64.tgz \
    ${ALIYUN_CLI_URL}/v${ALIYUN_CLI_VERSION}/aliyun-cli-${OS_TYPE}-${ALIYUN_CLI_VERSION}-amd64.tgz
fi
mkdir -p ~/bin
tar -xf /tmp/aliyun-cli-${OS_TYPE}-${ALIYUN_CLI_VERSION}-amd64.tgz -C ~/bin
