#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_x86_64
export GRPCURL_VERSION=1.7.0
export GRPCURL_DIR=grpcurl_${GRPCURL_VERSION}_${OS_TYPE}
export GRPCURL_PKG=${GRPCURL_DIR}.tar.gz
export GRPCURL_URL=https://github.com/fullstorydev/grpcurl/releases/download
export GRPCURL_URL=${GRPCURL_URL}/v${GRPCURL_VERSION}/${GRPCURL_PKG}

# install grpcurl
# https://github.com/fullstorydev/grpcurl
if [ "${OS_TYPE}" == "linux_x86_64" ]; then
  wget -O /tmp/${GRPCURL_PKG} ${GRPCURL_URL}
  mkdir -p /tmp/${GRPCURL_DIR}
  tar -xf /tmp/${GRPCURL_PKG} -C /tmp/${GRPCURL_DIR}
  mkdir -p ~/bin
  cp /tmp/${GRPCURL_DIR}/grpcurl ~/bin
  rm -r /tmp/${GRPCURL_DIR} /tmp/${GRPCURL_PKG}
fi
