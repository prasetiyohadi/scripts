#!/bin/sh
set -ex

export PACKER_VERSION=1.4.2

# check terraform version
if [ -f "$(which packer)" ]; then
  export PACKER_VERSION=$(packer version | grep ^is | awk '{print $2}' | sed 's/\.$//g')
  echo $PACKER_VERSION
fi

# install packer
wget -O /tmp/packer_${PACKER_VERSION}_linux_amd64.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
mkdir -p ~/bin
unzip /tmp/packer_${PACKER_VERSION}_linux_amd64.zip -d ~/bin
rm -f /tmp/packer_${PACKER_VERSION}_linux_amd64.zip