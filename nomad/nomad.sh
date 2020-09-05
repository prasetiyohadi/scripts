#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin_amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux_arm
export NOMAD_VERSION=0.12.3
export NOMAD_PKG=nomad_${NOMAD_VERSION}_${OS_TYPE}.zip
export NOMAD_URL=https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_${OS_TYPE}.zip

# install nomad
wget -O /tmp/${NOMAD_PKG} ${NOMAD_URL}
mkdir -p ~/bin
unzip /tmp/${NOMAD_PKG} -d ~/bin
rm -f /tmp/${NOMAD_PKG}
