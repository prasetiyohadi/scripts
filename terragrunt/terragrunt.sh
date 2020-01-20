#!/bin/sh
set -ex

export TERRAGRUNT_VERSION=v0.21.6

# install terragrunt
mkdir -p ~/bin
wget -O ~/bin/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
chmod +x ~/bin/terragrunt
