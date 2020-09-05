#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin_amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
export TERRAGRUNT_VERSION=v0.23.40
export TERRAGRUNT_URL=https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_${OS_TYPE}

# install terragrunt
# https://github.com/gruntwork-io/terragrunt
mkdir -p ~/bin
wget -O ~/bin/terragrunt ${TERRAGRUNT_URL}
chmod +x ~/bin/terragrunt
