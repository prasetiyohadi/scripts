#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=`echo ${OS} | tr -d ".[:digit:]"`
export OS_TYPE

if [ "${OS_TYPE}" != "linux-gnueabihf" ]; then
    # install kustomize
    # https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/
    curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
    mkdir -p ~/bin
    mv kustomize ~/bin/kustomize
fi
