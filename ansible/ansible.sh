#!/usr/bin/env bash
set -euxo pipefail

export ANSIBLE_VERSION=2.9.13

# install ansible
pip install --upgrade pip cffi
pip install ansible==${ANSIBLE_VERSION} google-auth requests
