#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux-gnu
APP_BIN=docker-compose
APP_URL=https://github.com/docker/compose/releases/download
APP_VERSION=1.29.2
APP_PATH=/usr/local/bin/$APP_BIN
APP_SRC=$APP_BIN-$(uname -s)-$(uname -m)
APP_URL=$APP_URL/$APP_VERSION/$APP_SRC
HAS_DOCKER_COMPOSE="$(type "docker-compose" &> /dev/null && echo true || echo false)"

check_version() {
    $APP_BIN version
}

install_linux() {
    sudo mkdir -p /usr/local/bin
    sudo curl -L "$APP_URL" -o $APP_PATH
    sudo chmod +x $APP_PATH
}

setup_darwin() {
    echo "This script will install $APP_BIN using brew."
    command -v brew > /dev/null && brew install $APP_BIN
}

setup_linux() {
    echo "This script will install $APP_BIN version $APP_VERSION."
    if [ "$HAS_DOCKER_COMPOSE" == "true" ]; then
        check_version
        read -p "$APP_BIN already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            APP_PATH=$(command -v $APP_BIN) install_linux
        else
            echo "Installation cancelled."
        fi
    else
        install_linux
    fi
}

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
        setup_darwin
    elif [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
        setup_linux
    fi
}

main
