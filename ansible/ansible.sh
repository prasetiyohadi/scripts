#!/usr/bin/env bash
set -euo pipefail

# install ansible (requires pipenv and pyenv)
# https://github.com/ansible/ansible
if command -v pipenv pyenv 1>/dev/null 2>&1; then
    CWD=$(dirname "$0")
    cd "$CWD"
    pipenv run pip install -U setuptools
    pipenv install
    pipenv shell
else
    echo "Install pipenv and pyenv first!"
fi
