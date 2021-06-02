#!/usr/bin/env bash
set -euxo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "${OS}" | tr -d "[:digit:]")
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin_amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux_arm
export VAULT_VERSION=1.7.2
export VAULT_PKG=vault_${VAULT_VERSION}_${OS_TYPE}.zip
export VAULT_URL=https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_${OS_TYPE}.zip

# install vault
wget -O /tmp/${VAULT_PKG} ${VAULT_URL}
mkdir -p ~/bin
unzip /tmp/${VAULT_PKG} -d ~/bin
rm -f /tmp/${VAULT_PKG}
