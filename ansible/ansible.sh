#!/bin/sh
set -ex

export ANSIBLE_VERSION=2.9.3

# install ansible
pip install --upgrade pip cffi
pip install ansible==${ANSIBLE_VERSION} google-auth requests
