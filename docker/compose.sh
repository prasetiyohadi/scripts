#!/usr/bin/env bash
set -euo pipefail

APP_VERSION=1.29.1
sudo mkdir -p /usr/local/bin
sudo curl -L "https://github.com/docker/compose/releases/download/$APP_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
