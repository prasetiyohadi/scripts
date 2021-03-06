#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export SKAFFOLD_URL=https://storage.googleapis.com/skaffold/releases/latest
export SKAFFOLD_URL=${SKAFFOLD_URL}/skaffold-${OS_TYPE}

# install skaffold
# https://github.com/GoogleContainerTools/skaffold
if [ "${OS_TYPE}" == "linux-amd64" ]; then
    curl -Lo /tmp/skaffold ${SKAFFOLD_URL}
    sudo install /tmp/skaffold /usr/local/bin/
    rm /tmp/skaffold
fi
