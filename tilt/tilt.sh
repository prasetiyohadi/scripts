#!/usr/bin/env bash
set -euo pipefail

export TILT_VERSION="0.20.5"
curl -fsSL https://github.com/tilt-dev/tilt/releases/download/v$TILT_VERSION/tilt.$TILT_VERSION.linux.x86_64.tar.gz | tar -xzvC /tmp tilt && \
  sudo mv /tmp/tilt /usr/local/bin/tilt
