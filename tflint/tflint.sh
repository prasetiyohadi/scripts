#!/usr/bin/env bash
set -euo pipefail

# install tflint
# https://github.com/terraform-linters/tflint
echo "This script will install tflint."
curl https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
