#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d ".[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux-arm64
export DENO_URL=https://deno.land/x/install/install.sh

if [[ "${OS_TYPE}" == "linux-amd64" || "${OS_TYPE}" == "linux-arm64" ]]; then
    # install deno
    curl -fsSL $DENO_URL | sh
elif [ "${OS_TYPE}" == "darwin" ]; then
    # install deno
    which brew > /dev/null && brew install deno
fi
