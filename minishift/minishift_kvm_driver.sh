#!/usr/bin/env bash
set -euxo pipefail

# docker-machine-kvm
# https://github.com/dhiltgen/docker-machine-kvm
sudo curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-ubuntu16.04 -o /usr/local/bin/docker-machine-driver-kvm
sudo chmod +x /usr/local/bin/docker-machine-driver-kvm
