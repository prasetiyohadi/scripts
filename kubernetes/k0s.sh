#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
export K0S_VERSION=0.7.0
export K0S_PKG=k0s-v${K0S_VERSION}
export K0S_URL=https://github.com/k0sproject/k0s/releases/download

# install k0s
# https://github.com/k0sproject/k0s
if [ "${OS_TYPE}" == "linux-gnu" ]; then
    sudo curl -Lo /usr/local/sbin/k0s ${K0S_URL}/v${K0S_VERSION}/${K0S_PKG}-amd64
    sudo chmod +x /usr/local/sbin/k0s
fi
