#!/bin/sh
set -ex

mkdir -p ~/bin
wget -q --show-progress --https-only --timestamping -P ~/bin \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssl \
  https://storage.googleapis.com/kubernetes-the-hard-way/cfssl/linux/cfssljson
chmod +x ~/bin/cfssl ~/bin/cfssljson
