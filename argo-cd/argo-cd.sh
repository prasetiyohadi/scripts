#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export ARGO_CD_BASEURL=https://github.com/argoproj/argo-cd/releases/download
export ARGO_CD_VERSION=1.8.3
export ARGO_CD_PKG=argocd-${OS_TYPE}
export ARGO_CD_URL=${ARGO_CD_BASEURL}/v${ARGO_CD_VERSION}/${ARGO_CD_PKG}

# install argocd
# https://github.com/argoproj/argo-cd
if [ "${OS_TYPE}" == "linux-amd64" ]; then
    mkdir -p ~/bin
    curl -Lo ~/bin/argocd ${ARGO_CD_URL}
    chmod +x ~/bin/argocd
fi
