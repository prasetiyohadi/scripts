#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export MINIKUBE_URL=https://storage.googleapis.com/minikube/releases/latest
export MINIKUBE_URL=${MINIKUBE_URL}/minikube-${OS_TYPE}

# install minikube
if [ "${OS_TYPE}" == "linux-amd64" ]; then
    curl -Lo /tmp/minikube ${MINIKUBE_URL}
    sudo install /tmp/minikube /usr/local/bin/
    rm /tmp/minikube
fi
