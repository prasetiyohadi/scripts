#!/usr/bin/env bash
set -euo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=linux_amd64
export YQ_PKG=yq_${OS_TYPE}
export YQ_VERSION=4.7.1
export YQ_URL=https://github.com/mikefarah/yq/releases/download
export YQ_URL=${YQ_URL}/v${YQ_VERSION}/${YQ_PKG}

# install yq
# https://github.com/mikefarah/yq
mkdir -p ~/bin
wget -O ~/bin/yq ${YQ_URL}
chmod +x ~/bin/yq
yq -V 
yq -h
