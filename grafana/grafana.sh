#!/usr/bin/env bash
set -euo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        # install prerequisites
        sudo apt-get update
        sudo apt-get install --assume-yes apt-transport-https software-properties-common wget
        wget --quiet --output-document=- https://packages.grafana.com/gpg.key \
            | sudo apt-key add -
        echo "deb https://packages.grafana.com/oss/deb stable main" \
            | sudo tee -a /etc/apt/sources.list.d/grafana.list 
        sudo apt-get update
        sudo apt-get install -y grafana
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    # install pyenv and prerequisites
    which brew > /dev/null && brew install grafana
fi
