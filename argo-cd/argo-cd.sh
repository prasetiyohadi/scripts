#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export ARGO_CD_APIURL=https://api.github.com/repos/argoproj/argo-cd
export ARGO_CD_APIURL=${ARGO_CD_APIURL}/releases/latest
export ARGO_CD_BASEURL=https://github.com/argoproj/argo-cd/releases/download
export ARGO_CD_VERSION=$(curl --silent "${ARGO_CD_APIURL}" \
    | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
export ARGO_CD_PKG=argocd-${OS_TYPE}
export ARGO_CD_URL=${ARGO_CD_BASEURL}/${ARGO_CD_VERSION}/${ARGO_CD_PKG}

# install argocd
# https://github.com/argoproj/argo-cd
if [ "${OS_TYPE}" == "linux-amd64" ]; then
    mkdir -p ~/bin
    curl -Lo ~/bin/argocd ${ARGO_CD_URL}
    chmod +x ~/bin/argocd
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew 2>&1 /dev/null && brew install argocd
fi
