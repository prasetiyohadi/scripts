#!/bin/bash
set -ex

export GCLOUD_SDK_ROOT=~/.local/google-cloud-sdk
export GCLOUD_SDK_VERSION=246.0.0

sudo apt update
sudo apt install python
wget -O /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
tar -xf /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz -C ~/.local
bash ${GCLOUD_SDK_ROOT}/install.sh
rm -f /tmp/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
