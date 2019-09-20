#!/bin/bash
set -ex

export ALIYUN_CLI_VERSION=3.0.26

if [ ! -f "/tmp/aliyun-cli-linux-${ALIYUN_CLI_VERSION}-amd64.tgz" ]; then
  wget -O /tmp/aliyun-cli-linux-${ALIYUN_CLI_VERSION}-amd64.tgz https://github.com/aliyun/aliyun-cli/releases/download/v${ALIYUN_CLI_VERSION}/aliyun-cli-linux-${ALIYUN_CLI_VERSION}-amd64.tgz
fi
tar -xf /tmp/aliyun-cli-linux-${ALIYUN_CLI_VERSION}-amd64.tgz -C $HOME/bin
