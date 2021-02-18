#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
export KUBESEAL_PKG=kubeseal-${OS_TYPE}
export KUBESEAL_VERSION=v0.14.1
export KUBESEAL_URL=https://github.com/bitnami-labs/sealed-secrets/releases
export KUBESEAL_URL=${KUBESEAL_URL}/download/${KUBESEAL_VERSION}
export KUBESEAL_URL=${KUBESEAL_URL}/${KUBESEAL_PKG}

if [ "${OS_TYPE}" == "linux-amd64" ]; then
  # install kubeseal client
  # https://github.com/bitnami-labs/sealed-secrets/releases
  mkdir -p ~/bin
  wget ${KUBESEAL_URL} -O /tmp/kubeseal
  sudo install -m 755 /tmp/kubeseal /usr/local/bin/kubeseal
  rm /tmp/kubeseal
  kubeseal --help
elif [ "${OS_TYPE}" == "darwin" ]; then
  which brew > /dev/null && brew install kubeseal
  kubeseal --help
fi
