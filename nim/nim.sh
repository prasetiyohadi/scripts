#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d ".[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux_x64
export NIM_VERSION=1.4.4
export NIM_SRC=nim-${NIM_VERSION}-${OS_TYPE}
export NIM_PKG=${NIM_SRC}.tar.xz
export NIM_URL=https://nim-lang.org/download/${NIM_PKG}

# install nim
# https://nim-lang.org/install_unix.html
if [[ "${OS_TYPE}" == "linux_x64" ]]; then
    wget -O /tmp/${NIM_PKG} ${NIM_URL}
    wget -O /tmp/${NIM_PKG}.sha256 ${NIM_URL}.sha256
    echo "$(cat /tmp/${NIM_PKG}.sha256|awk '{print $1}') /tmp/${NIM_PKG}" > /tmp/nim.sum
    sha256sum -c /tmp/nim.sum
    tar -xf /tmp/${NIM_PKG} -C /tmp
    mkdir -p ~/.local
    mv /tmp/nim-${NIM_VERSION} ~/.local/nim
    rm /tmp/${NIM_PKG} /tmp/${NIM_PKG}.sha256 /tmp/nim.sum
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install nim
fi
