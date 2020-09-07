#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

# install pipx
# https://github.com/pipxproject/pipx
if [ "${OS_TYPE}" == "linux-gnu" ]; then
    python3 -m pip install --user pipx
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install pipx && pipx ensurepath
fi
