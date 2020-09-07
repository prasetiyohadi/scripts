#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

# install pipenv
# https://github.com/pypa/pipenv
if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install -y pipenv
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install pipenv
fi
