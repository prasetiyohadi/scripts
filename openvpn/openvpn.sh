#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install -y openvpn
        if [ -d ~/openvpn ]; then
            sudo mv -f /etc/openvpn{,.orig}
            sudo ln -s ~/openvpn /etc/openvpn
            sudo systemctl disable systemd-ask-password-wall.path systemd-ask-password-wall.service
            sudo systemctl stop systemd-ask-password-wall.path systemd-ask-password-wall.service
        fi
    fi
fi
