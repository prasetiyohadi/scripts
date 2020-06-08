#!/bin/bash
set -ex

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin-amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export HELM_VERSION=v3.2.2
export HELM_URL=https://get.helm.sh/helm-${HELM_VERSION}-${OS_TYPE}.tar.gz

# install helm
if [ ! -f /tmp/ ];
then
  wget -O /tmp/helm-${HELM_VERSION}-${OS_TYPE}.tar.gz \
    ${HELM_URL}
fi
mkdir -p /tmp/helm-${HELM_VERSION}-${OS_TYPE}
tar -zxvf /tmp/helm-${HELM_VERSION}-${OS_TYPE}.tar.gz \
  -C /tmp/helm-${HELM_VERSION}-${OS_TYPE}
mkdir -p ~/bin
mv /tmp/helm-${HELM_VERSION}-${OS_TYPE}/${OS_TYPE}/helm ~/bin/helm

#rm -rf /tmp/helm-${HELM_VERSION}-${OS_TYPE} \
#  /tmp/helm-${HELM_VERSION}-${OS_TYPE}.tar.gz
