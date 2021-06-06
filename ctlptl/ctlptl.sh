#!/usr/bin/env bash
set -euo pipefail

export CTLPTL_VERSION="0.5.0"
curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v$CTLPTL_VERSION/ctlptl.$CTLPTL_VERSION.linux.x86_64.tar.gz | tar -xzvC /tmp ctlptl && \
  sudo mv /tmp/ctlptl /usr/local/bin/ctlptl
