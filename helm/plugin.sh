#!/usr/bin/env bash
set -euo pipefail

which helm > /dev/null && export HELM_EXISTS=0

if [[ $HELM_EXISTS ]]; then
    echo "This script will install helm plugins."
    helm plugin install https://github.com/databus23/helm-diff
    helm plugin install https://github.com/aslafy-z/helm-git
    helm plugin install https://github.com/jkroepke/helm-secrets
else
    echo "Helm is not found in PATH."
fi
