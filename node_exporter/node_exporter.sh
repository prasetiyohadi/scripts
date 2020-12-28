#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export NE_BASEURL=https://github.com/prometheus/node_exporter/releases/download
export NE_VERSION=1.0.1
export NE_PKG=node_exporter-${NE_VERSION}.${OS_TYPE}.tar.gz
export NE_SHA256=${NE_BASEURL}/v${NE_VERSION}/sha256sums.txt
export NE_URL=${NE_BASEURL}/v${NE_VERSION}/${NE_PKG}

# install node_exporter
# https://github.com/prometheus/node_exporter
if [ "${OS_TYPE}" == "linux-amd64" ]; then
    wget -O /tmp/${NE_PKG} ${NE_URL}
    wget -O /tmp/sha256sums.txt ${NE_SHA256}
    echo "$(grep ${OS_TYPE} /tmp/sha256sums.txt \
        | awk '{print $1}') /tmp/${NE_PKG}" > /tmp/node_exporter.sum
    sha256sum -c /tmp/node_exporter.sum
    tar -xf /tmp/${NE_PKG} -C /tmp
    sudo cp /tmp/node_exporter-${NE_VERSION}.${OS_TYPE}/node_exporter \
        /usr/local/bin
    rm -fr /tmp/node_exporter-${NE_VERSION}.${OS_TYPE}/node_exporter \
        /tmp/node_exporter.sum \
        /tmp/sha256sums.txt \
        /tmp/${NE_PKG}
fi
