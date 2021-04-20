#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
export OS_TYPE
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=linux
export ALIYUN_CLI_VERSION=3.0.73
export ALIYUN_CLI_PKG="aliyun-cli-$OS_TYPE-$ALIYUN_CLI_VERSION-amd64.tgz"
export ALIYUN_CLI_URL="https://aliyuncli.alicdn.com/$ALIYUN_CLI_PKG"

# install aliyun CLI
# https://github.com/aliyun/aliyun-cli
clean() {
    rm -f "/tmp/$ALIYUN_CLI_PKG"
}

download() {
    wget -O "/tmp/$ALIYUN_CLI_PKG" "$ALIYUN_CLI_URL"
}

install() {
    mkdir -p ~/bin
    tar -xf "/tmp/$ALIYUN_CLI_PKG" -C ~/bin
}

main() {
    download
    install
    clean
}

if [[ "${OS_TYPE}" == "linux" ]]; then
    main
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install aliyun-cli
fi
