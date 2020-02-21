#!/bin/bash
set -ex

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin_amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux_arm
export TERRAFORM_VERSION=0.12.21

# check terraform version
if [ -f "`which terraform`" ]; then
  export NEW_VERSION=`terraform version | grep ^is | awk '{print $2}' | sed 's/\.$//g'`
  if [ ! "$NEW_VERSION" == "" ]; then
    echo "New version available: $TERRAFORM_VERSION"
    export TERRAFORM_VERSION=$NEW_VERSION
  fi
fi

export TERRAFORM_PKG=terraform_${TERRAFORM_VERSION}_${OS_TYPE}.zip
export TERRAFORM_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_${OS_TYPE}.zip

# install terraform
wget -O /tmp/${TERRAFORM_PKG} ${TERRAFORM_URL}
mkdir -p ~/bin
unzip /tmp/${TERRAFORM_PKG} -d ~/bin
rm -f /tmp/${TERRAFORM_PKG}
