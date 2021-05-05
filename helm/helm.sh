#!/usr/bin/env bash
set -euo pipefail

OS="${OSTYPE:-'linux-gnu'}"
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=darwin-amd64
OS_TYPE_LINUX_AMD64=linux-amd64
OS_TYPE_LINUX_ARM=linux-arm
[ "$OS_TYPE" == "darwin" ] && export OS_TYPE="$OS_TYPE_DARWIN"
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE="$OS_TYPE_LINUX_AMD64"
[ "$OS_TYPE" == "linux-gnueabihf" ] && export OS_TYPE="$OS_TYPE_LINUX_ARM"
APP_BIN=helm
APP_VERSION=v3.5.4
APP_SRC="$APP_BIN-$APP_VERSION-$OS_TYPE"
APP_PKG="$APP_SRC.tar.gz"
APP_URL="https://get.helm.sh/$APP_PKG"

# install helm
# https://helm.sh/docs/intro/install/
clean() {
    rm -rf /tmp/$APP_SRC /tmp/$APP_PKG
}

download() {
    wget -O /tmp/$APP_PKG $APP_URL
}

install() {
    mkdir -p /tmp/$APP_SRC ~/bin
    tar -xf /tmp/$APP_PKG -C /tmp/$APP_SRC
    mv /tmp/$APP_SRC/$OS_TYPE/$APP_BIN ~/bin
}

# initialize a helm chart repository
# https://helm.sh/docs/intro/quickstart/
add_repo() {
    $APP_BIN repo add stable https://charts.helm.sh/stable
    $APP_BIN repo add bitnami https://charts.bitnami.com/bitnami
    $APP_BIN repo add gitlab https://charts.gitlab.io
    $APP_BIN repo add hashicorp https://helm.releases.hashicorp.com
    $APP_BIN repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    $APP_BIN repo add jetstack https://charts.jetstack.io
    $APP_BIN repo add prometheus-community https://prometheus-community.github.io/helm-charts
    $APP_BIN repo update
}

setup() {
    download
    install
    clean
    add_repo
}

main_linux() {
    echo "This script will install $APP_BIN version $APP_VERSION."
    if [ -s "$HOME/bin/$APP_BIN" ]; then
        read -p "$HOME/bin/$APP_BIN already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            setup
        else
            echo "Installation cancelled."
        fi
    else
        setup
    fi
}

main_darwin() {
    echo "This script will install $APP_BIN version $APP_VERSION using brew."
    which brew > /dev/null && brew install $APP_BIN
    add_repo
}

main() {
    if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ] \
        || [ "$OS_TYPE" == "$OS_TYPE_LINUX_ARM" ]; then
        main_linux
    elif [ "$OS_TYPE" == "$OS_TYPE_DARWIN" ]; then
        main_darwin
    fi
}

main
