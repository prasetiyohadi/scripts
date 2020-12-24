#!/usr/bin/env bash
set -euo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin-amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux-armv6l
export GO_VERSION=${GO_VERSION:-$(curl -s https://golang.org/VERSION?m=text)}
export GO_URL=https://dl.google.com/go/${GO_VERSION}.${OS_TYPE}.tar.gz
export GO_INSTALL_PATH=~/.local
export GOROOT=~/.local/go
export GOPATH=~/go

echo "This script will install Go language version ${GO_VERSION}."

if [ "${OS_TYPE}" == "linux-amd64" ]; then
    # install go
    if [ -d ${GOROOT} ]; then
        read -p "${GOROOT} already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -r ${GOROOT}
            mkdir -p ${GO_INSTALL_PATH} ${GOPATH}
            wget -O - ${GO_URL} | tar -C ${GO_INSTALL_PATH} -zxf -
        fi
    else
        mkdir -p ${GO_INSTALL_PATH} ${GOPATH}
        wget -O - ${GO_URL} | tar -C ${GO_INSTALL_PATH} -zxf -
    fi
fi
