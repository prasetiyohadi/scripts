#!/bin/sh
set -ex

export OS=${OSTYPE:-'linux'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux" ]; then
  # install minio client
  if [ ! -f /usr/local/bin/mc ]; then
    sudo wget -P /usr/local/bin https://dl.min.io/client/mc/release/linux-amd64/mc
    sudo chmod +x /usr/local/bin/mc
    mc --help
  fi
elif [ "${OS_TYPE}" == "darwin" ]; then
  which brew > /dev/null && brew install minio/stable/mc
  mc --help
fi
