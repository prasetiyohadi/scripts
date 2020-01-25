#!/bin/bash
set -ex

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
  # install minio client
  if [ ! -f ~/bin/mc ]; then
    mkdir -p ~/bin
    sudo wget -P ~/bin https://dl.min.io/client/mc/release/linux-amd64/mc
    sudo chmod +x ~/bin/mc
    mc --help
  fi
elif [ "${OS_TYPE}" == "darwin" ]; then
  which brew > /dev/null && brew install minio/stable/mc
  mc --help
fi
