#!/bin/bash
set -ex

# check if go is installed
if [ -f "`which go`" ]; then
  go get -u -v github.com/cloudflare/cfssl/cmd/...
else
  echo "Go is not installed. Install go first."
fi
