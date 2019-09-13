#!/bin/bash
set -ex

export MINISHIFT_VERSION=1.34.1

# install minishift
wget -O /tmp/minishift-${MINISHIFT_VERSION}-linux-amd64.tgz https://github.com/minishift/minishift/releases/download/v${MINISHIFT_VERSION}/minishift-${MINISHIFT_VERSION}-linux-amd64.tgz
mkdir -p ~/bin
tar -zxvf /tmp/minishift-${MINISHIFT_VERSION}-linux-amd64.tgz -C /tmp
mv /tmp/minishift-${MINISHIFT_VERSION}-linux-amd64/minishift ~/bin
rm -frv /tmp/minishift-${MINISHIFT_VERSION}-linux-amd64
rm -fv /tmp/minishift-${MINISHIFT_VERSION}-linux-amd64.tgz
