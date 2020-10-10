#!/usr/bin/env bash
set -exo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
export KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release
export KUBECTL_STABLE=$(curl -s ${KUBECTL_URL}/stable.txt)
[ -z "${KUBECTL_VERSION}" ] && export KUBECTL_VERSION=${KUBECTL_STABLE}

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    # install kubectl
    mkdir -p ~/bin
    curl -LO "${KUBECTL_URL}/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
    mv ./kubectl ~/bin
    chmod +x ~/bin/kubectl
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install kubectl
fi
