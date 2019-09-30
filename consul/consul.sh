#!/bin/sh
set -ex

export CONSUL_VERSION=1.6.1

# install consul
wget -O /tmp/consul_${CONSUL_VERSION}_linux_amd64.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip
mkdir -p ~/bin
unzip /tmp/consul_${CONSUL_VERSION}_linux_amd64.zip -d ~/bin
rm -f /tmp/consul_${CONSUL_VERSION}_linux_amd64.zip
