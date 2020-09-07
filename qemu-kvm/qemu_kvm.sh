#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        # install qemu-kvm
        sudo apt-get update
        sudo apt-get install -y qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager
        # add user to libvirt group
        sudo usermod -aG kvm $USER
        sudo usermod -aG libvirt $USER
        sudo usermod -aG libvirt-qemu $USER
    fi
fi
