#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d ".[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux-arm64
export KIND_VERSION=v0.10.0
export KIND_URL=https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-${OS_TYPE}

if [[ "${OS_TYPE}" == "linux-amd64" || "${OS_TYPE}" == "linux-arm64" ]]; then
    # install kind
    mkdir -p ~/bin
    curl -Lo ~/bin/kind ${KIND_URL}
    chmod +x ~/bin/kind
elif [ "${OS_TYPE}" == "darwin" ]; then
    # install kind
    which brew > /dev/null && brew install kind
fi
