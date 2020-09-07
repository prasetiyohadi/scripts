#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

# install poetry
# https://github.com/python-poetry/poetry
if [ "${OS_TYPE}" == "linux-gnu" ]; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install poetry
fi
