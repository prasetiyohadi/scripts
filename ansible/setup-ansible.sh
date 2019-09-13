#!/bin/bash
set -ex

export ANSIBLE_VERSION=2.7.10

# install ansible
pip install --upgrade pip cffi
pip install --user ansible==${ANSIBLE_VERSION} google-auth requests
