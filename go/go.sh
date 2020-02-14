#!/bin/bash
set -ex

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin-amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux-armv6l
export GO_VERSION=1.13.7
export GO_URL=https://dl.google.com/go/go${GO_VERSION}.${OS_TYPE}.tar.gz
export GO_INSTALL_PATH=~/.local
export GOROOT=~/.local/go
export GOPATH=~/go

# install go
if [ -d ${GOROOT} ]; then
  rm -r ${GOROOT}
else
  mkdir -p ${GO_INSTALL_PATH} ${GOPATH}
  wget -O - ${GO_URL} | tar -C ${GO_INSTALL_PATH} -zxf -
fi
