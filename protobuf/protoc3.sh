#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=osx-x86_64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-x86_64
export PROTOC3_VERSION=3.14.0
export PROTOC3_PKG=protoc-${PROTOC3_VERSION}-${OS_TYPE}.zip
export PROTOC3_URL=https://github.com/protocolbuffers/protobuf
export PROTOC3_URL=${PROTOC3_URL}/releases/download
export PROTOC3_URL=${PROTOC3_URL}/v${PROTOC3_VERSION}/${PROTOC3_PKG}

# install protobuf compiler
# https://github.com/protocolbuffers/protobuf
cd "$(mktemp -d)"
curl -fsSLO "${PROTOC3_URL}"
unzip ${PROTOC3_PKG} -d protoc3
sudo mv protoc3/bin/* /usr/local/bin/
sudo mv protoc3/include/* /usr/local/include/
sudo chown $USER /usr/local/bin/protoc
sudo chown -R $USER /usr/local/include/google

# test
protoc --version
