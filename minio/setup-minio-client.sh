#!/bin/bash
set -ex

# install minio client
if [ ! -f ~/bin/mc ]; then
  wget -P ~/bin https://dl.min.io/client/mc/release/linux-amd64/mc
  chmod +x ~/bin/mc
  ~/bin/mc --help
fi
