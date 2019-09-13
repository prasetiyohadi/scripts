#!/bin/bash
set -ex

export TERRAGRUNT_VERSION=v0.19.23

# install terragrunt
wget -O ~/bin/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64
chmod +x ~/bin/terragrunt
