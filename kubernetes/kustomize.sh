#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" != "linux-gnueabihf" ]; then
    # install kustomize
    # https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/
    curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
    mkdir -p ~/bin
    mv kustomize ~/bin/kustomize
fi
