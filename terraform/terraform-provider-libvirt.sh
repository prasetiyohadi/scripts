#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
export TF_LIBVIRT_VERSION=0.6.2
export TF_LIBVIRT_URL=https://github.com/dmacvicar/terraform-provider-libvirt.git

# install terraform-provider-libvirt
# https://github.com/dmacvicar/terraform-provider-libvirt
if command -v go terraform 1>/dev/null 2>&1; then
    if [ "${OS_TYPE}" == "linux-gnu" ]; then
        if [ -f /etc/debian_version ]; then
            sudo apt-get update
            sudo apt-get install -y genisoimage libvirt-dev
        fi
        if [ -d $GH/../dmacvicar/terraform-provider-libvirt ]; then
            cd $GH/../dmacvicar/terraform-provider-libvirt
            git pull origin v${TF_LIBVIRT_VERSION}
            git checkout v${TF_LIBVIRT_VERSION}
        else
            mkdir -p $GH/../dmacvicar
            cd $GH/../dmacvicar
            git clone -b v${TF_LIBVIRT_VERSION} ${TF_LIBVIRT_URL}
            cd $GH/../dmacvicar/terraform-provider-libvirt
        fi
        export GO111MODULE=on
        export GOFLAGS=-mod=vendor
        go mod vendor
        make install
    fi
else
    echo "Install golang and terraform first!"
fi
