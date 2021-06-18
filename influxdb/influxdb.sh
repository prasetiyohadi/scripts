#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_ID=""
[ -f "/etc/os-release" ] && source /etc/os-release && OS_ID=$ID
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_DARWIN=darwin
OS_TYPE_LINUX_AMD64=linux-gnu
APP_BIN=grafana
APP_PATH=/usr/bin/$APP_BIN

check_version() {
    $APP_BIN --version
}

install_linux() {
    if [ "$OS_ID" == "debian" ]; then
        wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
        source /etc/os-release
        echo "deb https://repos.influxdata.com/debian $(lsb_release -cs) stable" \
            | sudo tee /etc/apt/sources.list.d/influxdb.list
        sudo apt-get update
        sudo apt-get install --assume-yes $APP_BIN
    elif [ "$OS_ID" == "centos" ] || [ "$OS_ID" == "fedora" ]; then
        cat <<EOF | sudo tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
        sudo dnf install --assumeyes $APP_BIN
    fi
}

setup_darwin() {
    echo "This script will install $APP_BIN using brew."
    command -v brew > /dev/null && brew install $APP_BIN
}

setup_linux() {
    echo "This script will install $APP_BIN."
    if [ -s "$APP_PATH" ]; then
        check_version
        read -p "$APP_PATH already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            install_linux
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
