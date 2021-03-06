#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d ".[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=Linux_x86_64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=Linux_arm
export K9S_VERSION=0.24.2
export K9S_URL=https://github.com/derailed/k9s/releases/download
export K9S_URL=${K9S_URL}/v${K9S_VERSION}/k9s_${OS_TYPE}.tar.gz

if [[ "${OS_TYPE}" == "Linux_x86_64" || "${OS_TYPE}" == "Linux_arm" ]]; then
    # install k9s
    mkdir -p ~/bin /tmp/k9s
    wget -O - ${K9S_URL} | tar -C /tmp/k9s -zxf -
    mv /tmp/k9s/k9s ~/bin
    rm -r /tmp/k9s
elif [ "${OS_TYPE}" == "darwin" ]; then
    # install k9s
    which brew > /dev/null && brew install derailed/k9s/k9s
fi
