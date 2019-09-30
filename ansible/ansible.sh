#!/bin/sh
set -ex

export ANSIBLE_VERSION=2.8.5

# install ansible
pip install --upgrade pip cffi
pip install --user ansible==${ANSIBLE_VERSION} google-auth requests
