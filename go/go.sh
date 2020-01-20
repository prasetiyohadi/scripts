#!/bin/sh
set -ex

export OS=${OSTYPE:-'linux'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
export GO_VERSION=1.13.6
export GO_URL=https://dl.google.com/go/go${GO_VERSION}.${OS_TYPE}-amd64.tar.gz
export GO_INSTALL_PATH=~/.local
export GOROOT=~/.local/go
export GOPATH=~/go

# install go
if [ -d ${GOROOT} ]; then
  rm -r ${GOROOT}
else
  mkdir -p ${GOPATH}
  wget -O - ${GO_URL} | tar -C ${GO_INSTALL_PATH} -zxf -
fi
