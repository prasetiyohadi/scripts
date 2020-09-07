#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
export VAGRANT_VERSION=2.2.10
export VAGRANT_URL=https://releases.hashicorp.com/vagrant
export VAGRANT_URL=${VAGRANT_URL}/${VAGRANT_VERSION}

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
        sudo apt-add-repository \
            "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
        sudo apt-get update
        sudo apt-get install -y consul nomad packer terraform vault
        export VAGRANT_PKG=vagrant_${VAGRANT_VERSION}_x86_64.deb
        export VAGRANT_URL=${VAGRANT_URL}/vagrant_${VAGRANT_VERSION}_x86_64.deb
        wget -O /tmp/${VAGRANT_PKG} ${VAGRANT_URL}
        sudo apt-get install -y /tmp/${VAGRANT_PKG}
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    brew install hashicorp/tap/consul hashicorp/tap/nomad hashicorp/tap/packer \
        hashicorp/tap/terraform hashicorp/tap/vault
    export VAGRANT_PKG=vagrant_${VAGRANT_VERSION}_x86_64.dmg
    export VAGRANT_URL=${VAGRANT_URL}/vagrant_${VAGRANT_VERSION}_x86_64.dmg
    wget -O ~/${VAGRANT_PKG} ${VAGRANT_URL}
fi
