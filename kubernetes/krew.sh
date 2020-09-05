#!/bin/sh
set -ex

KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64"
KREW_ROOT=$HOME

cd "$(mktemp -d)"
curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}"
tar -xf krew.tar.gz
"$KREW" install --manifest=krew.yaml --archive=krew.tar.gz
"$KREW" update

# Add $HOME/.krew/bin directory to your PATH environment variable
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
