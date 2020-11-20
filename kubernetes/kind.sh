#!/bin/sh
set -ex

export KIND_VERSION=v0.9.0

mkdir -p ~/bin
curl -Lo ~/bin/kind https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-$(uname)-amd64
chmod +x ~/bin/kind
