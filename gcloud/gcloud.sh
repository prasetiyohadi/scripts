#!/bin/sh
set -ex

export GCLOUD_SDK_ROOT=~/.local/google-cloud-sdk
export GCLOUD_SDK_VERSION=264.0.0

sudo apt update
sudo apt install python
if [ ! -f /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz ]; then
  wget -O /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
fi
tar -xf /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz -C ~/.local
sh ${GCLOUD_SDK_ROOT}/install.sh --quiet
rm -f /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
