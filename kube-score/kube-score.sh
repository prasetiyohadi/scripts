#!/usr/bin/env bash
set -euo pipefail

# install kube-score
# https://github.com/zegl/kube-score
echo "This script will install kube-score."
which kubectl-krew > /dev/null && kubectl-krew install score
