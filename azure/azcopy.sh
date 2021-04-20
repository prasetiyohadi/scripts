#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
export OS_TYPE
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_amd64
export AZCOPY_VERSION=10.8.0
export AZCOPY_TMP=azcopy_${OS_TYPE}_${AZCOPY_VERSION}
export AZCOPY_PKG=${AZCOPY_TMP}.tar.gz
export AZCOPY_URL=https://azcopyvnext.azureedge.net/release20201211/
export AZCOPY_URL=${AZCOPY_URL}/${AZCOPY_PKG}

if [ "${OS_TYPE}" == "linux_amd64" ]; then
    [[ ! -f "/tmp/${AZCOPY_PKG}" ]] && wget -O /tmp/${AZCOPY_PKG} ${AZCOPY_URL}
    mkdir -p /tmp/${AZCOPY_TMP}
    tar -xf /tmp/${AZCOPY_PKG} -C /tmp
    mkdir -p ~/bin
    mv /tmp/${AZCOPY_TMP}/azcopy ~/bin/azcopy
    rm -rf /tmp/${AZCOPY_TMP} /tmp/${AZCOPY_PKG}
fi
