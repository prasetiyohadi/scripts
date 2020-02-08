#!/bin/sh
set -ex

export GCLOUD_SDK_ROOT=$HOME/.local/google-cloud-sdk
export GCLOUD_SDK_URL=https://dl.google.com/dl/cloudsdk/channels/rapid/downloads
export GCLOUD_SDK_VERSION=279.0.0

if [ ! -f /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz ];
then
  wget -O /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    ${GCLOUD_SDK_URL}/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
fi
mkdir -p $HOME/.local
tar -xf /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
  -C $HOME/.local
sh ${GCLOUD_SDK_ROOT}/install.sh --quiet
sh ${GCLOUD_SDK_ROOT}/bin/gcloud -q components update
sh ${GCLOUD_SDK_ROOT}/bin/gcloud -q components install kubectl

#rm -f /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
