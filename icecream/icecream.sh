#!/usr/bin/env bash
set -euo pipefail

which pip > /dev/null && export PIP_EXISTS=0
if [[ $PIP_EXISTS ]]; then
    pip install icecream
fi
