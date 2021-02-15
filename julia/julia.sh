#!/usr/bin/env bash
set -euo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d ".[:digit:]"`
export JULIA_VERSION=1.5.3
export JULIA_MAJOR_VERSION=1.5
export JULIA_INSTALL_PATH=~/.local
export JULIAROOT=~/.local/julia

echo "This script will install Julia language version ${JULIA_VERSION}."

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    export JULIA_URL=https://julialang-s3.julialang.org/bin/linux/x64
    export JULIA_URL=${JULIA_URL}/${JULIA_MAJOR_VERSION}
    export JULIA_URL=${JULIA_URL}/julia-${JULIA_VERSION}-linux-x86_64.tar.gz
    # install julia
    if [ -d ${JULIAROOT} ]; then
        read -p "${JULIAROOT} already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -r ${JULIAROOT}
            mkdir -p ${JULIA_INSTALL_PATH}
            wget -O - ${JULIA_URL} | tar -C ${JULIA_INSTALL_PATH} -zxf -
            mv ${JULIA_INSTALL_PATH}/julia{-${JULIA_VERSION},}
        fi
    else
        mkdir -p ${JULIA_INSTALL_PATH}
        wget -O - ${JULIA_URL} | tar -C ${JULIA_INSTALL_PATH} -zxf -
        mv ${JULIA_INSTALL_PATH}/julia{-${JULIA_VERSION},}
    fi
elif [ "${OS_TYPE}" == "linux-gnueabihf" ]; then
    export JULIA_URL=https://julialang-s3.julialang.org/bin/linux/aarch64
    export JULIA_URL=${JULIA_URL}/${JULIA_MAJOR_VERSION}
    export JULIA_URL=${JULIA_URL}/julia-${JULIA_VERSION}-linux-aarch64.tar.gz
    # install julia
    if [ -d ${JULIAROOT} ]; then
        read -p "${JULIAROOT} already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -r ${JULIAROOT}
            mkdir -p ${JULIA_INSTALL_PATH}
            wget -O - ${JULIA_URL} | tar -C ${JULIA_INSTALL_PATH} -zxf -
            mv ${JULIA_INSTALL_PATH}/julia{-${JULIA_VERSION},}
        fi
    else
        mkdir -p ${JULIA_INSTALL_PATH}
        wget -O - ${JULIA_URL} | tar -C ${JULIA_INSTALL_PATH} -zxf -
        mv ${JULIA_INSTALL_PATH}/julia{-${JULIA_VERSION},}
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    export JULIA_URL=https://julialang-s3.julialang.org/bin/mac/x64
    export JULIA_URL=${JULIA_URL}/${JULIA_MAJOR_VERSION}
    export JULIA_URL=${JULIA_URL}/julia-${JULIA_VERSION}-mac64.dmg
    export JULIA_PKG=julia-${JULIA_VERSION}-mac64.dmg
    wget -O ~/${JULIA_PKG} ${JULIA_URL}
fi
