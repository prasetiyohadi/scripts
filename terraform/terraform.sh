#!/bin/sh
set -ex

export TERRAFORM_VERSION=0.11.13
export TERRAGRUNT_VERSION=v0.18.5

# check terraform version
if [ -f "$(which terraform)" ]; then
  export TERRAFORM_VERSION=$(terraform version | grep ^is | awk '{print $2}' | sed 's/\.$//g')
  echo $TERRAFORM_VERSION
fi

# install terraform
wget -O /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
mkdir -p ~/bin
unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d ~/bin
rm -f /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
