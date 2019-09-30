#!/bin/sh
set -ex

export VAULT_VERSION=1.2.2

# install vault
wget -O /tmp/vault_${VAULT_VERSION}_linux_amd64.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
mkdir -p ~/bin
unzip /tmp/vault_${VAULT_VERSION}_linux_amd64.zip -d ~/bin
rm -f /tmp/vault_${VAULT_VERSION}_linux_amd64.zip
