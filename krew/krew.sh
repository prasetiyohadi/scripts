#!/usr/bin/env bash
set -euo pipefail

export KREW_ROOT="$HOME"

# install krew
# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
echo "This script will install krew."
which git > /dev/null && export GIT_EXISTS=0
if [ "$GIT_EXISTS" == "0" ]; then
    (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
    tar zxvf krew.tar.gz &&
    KREW=./krew-"${OS}_${ARCH}" &&
    "$KREW" install krew
    )

    # update PATH
    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
    kubectl-krew update
fi
