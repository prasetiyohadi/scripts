#!/usr/bin/env bash
set -euo pipefail

which go > /dev/null && export GO_EXISTS=0
if [[ $GO_EXISTS ]]; then
    echo "This script will install oj."
    go get github.com/ohler55/ojg/cmd/oj
fi
