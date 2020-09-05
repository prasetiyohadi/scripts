#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=linux
export MINISHIFT_VERSION=1.34.2
export MINISHIFT_URL=https://github.com/minishift/minishift/releases/download

# install minishift
# https://github.com/minishift/minishift
wget -O /tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz \
    ${MINISHIFT_URL}/v${MINISHIFT_VERSION}/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz
wget -O /tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz.sha256 \
    ${MINISHIFT_URL}/v${MINISHIFT_VERSION}/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz.sha256
echo "$(cat /tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz.sha256) \
/tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz" > /tmp/minishift.sum
sha256sum -c /tmp/minishift.sum
tar -xf /tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz -C /tmp
mkdir -p ~/bin
mv /tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64/minishift ~/bin
rm -fr /tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64 \
    /tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz \
    /tmp/minishift-${MINISHIFT_VERSION}-${OS_TYPE}-amd64.tgz.sha256 \
    /tmp/minishift.sum
