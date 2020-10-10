#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin_amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux_armhfv6
export CONSUL_VERSION=1.8.4
export CONSUL_PKG=consul_${CONSUL_VERSION}_${OS_TYPE}.zip
export CONSUL_URL=https://releases.hashicorp.com/consul/${CONSUL_VERSION}
export CONSUL_URL=${CONSUL_URL}/${CONSUL_PKG}

# install consul
wget -O /tmp/${CONSUL_PKG} ${CONSUL_URL}
mkdir -p ~/bin
unzip /tmp/${CONSUL_PKG} -d ~/bin
rm -f /tmp/${CONSUL_PKG}
