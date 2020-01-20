#!/bin/sh
set -ex

export GCLOUD_SDK_ROOT=~/.local/google-cloud-sdk
export GCLOUD_SDK_URL=https://dl.google.com/dl/cloudsdk/channels/rapid/downloads
export GCLOUD_SDK_VERSION=276.0.0

if [ ! -f /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz ];
then
  wget -O /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    ${GCLOUD_SDK_URL}/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
fi
mkdir -p ~/.local
tar -xf /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  -C ~/.local
sh ${GCLOUD_SDK_ROOT}/install.sh --quiet
rm -f /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
