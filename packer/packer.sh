#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin_amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux_arm
export PACKER_VERSION=1.6.6

# check packer version
if [ -f "`which packer`" ]; then
  export NEW_VERSION=`packer version | grep ^is | awk '{print $2}' | sed 's/\.$//g'`
  if [ ! "$NEW_VERSION" == "" ]; then
    echo "New version available: $PACKER_VERSION"
    export PACKER_VERSION=$NEW_VERSION
  fi
fi

export PACKER_PKG=packer_${PACKER_VERSION}_${OS_TYPE}.zip
export PACKER_URL=https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_${OS_TYPE}.zip

# install packer
wget -O /tmp/${PACKER_PKG} ${PACKER_URL}
mkdir -p ~/bin
unzip /tmp/${PACKER_PKG} -d ~/bin
rm -f /tmp/${PACKER_PKG}
