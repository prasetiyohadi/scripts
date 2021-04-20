#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        # https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
        sudo apt-get update
        sudo apt-get install apt-transport-https ca-certificates curl lsb-release gnupg
        curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
        echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
        sudo apt-get update
        sudo apt-get install azure-cli
    elif [ -f /etc/redhat-release ]; then
        # https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=yum
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
        sudo yum install azure-cli
    fi
fi
