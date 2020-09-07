#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
export VAGRANT_VERSION=2.2.10
export VAGRANT_URL=https://releases.hashicorp.com/vagrant
export VAGRANT_URL=${VAGRANT_URL}/${VAGRANT_VERSION}

if [ ! "${OS_TYPE}" == "darwin" ]; then
    # install vagrant
    export VAGRANT_PKG=vagrant_${VAGRANT_VERSION}_${OS_TYPE}.zip
    export VAGRANT_URL=${VAGRANT_URL}/vagrant_${VAGRANT_VERSION}_${OS_TYPE}.zip
    wget -O /tmp/${VAGRANT_PKG} ${VAGRANT_URL}
    mkdir -p ~/bin
    unzip /tmp/${VAGRANT_PKG} -d ~/bin
    rm -f /tmp/${VAGRANT_PKG}
else
    export VAGRANT_PKG=vagrant_${VAGRANT_VERSION}_x86_64.dmg
    export VAGRANT_URL=${VAGRANT_URL}/vagrant_${VAGRANT_VERSION}_x86_64.dmg
    wget -O ~/${VAGRANT_PKG} ${VAGRANT_URL}
fi
