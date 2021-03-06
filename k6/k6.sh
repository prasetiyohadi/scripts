#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

# install k6
# https://k6.io/docs/getting-started/installation
if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
          --recv-keys 379CE192D401AB61
        echo "deb https://dl.bintray.com/loadimpact/deb stable main" | sudo \
            tee -a /etc/apt/sources.list.d/k6.list
        sudo apt-get update
        sudo apt-get install --assume-yes k6
    elif [ -f /etc/redhat-release ]; then
        wget https://bintray.com/loadimpact/rpm/rpm -O \
            bintray-loadimpact-rpm.repo
        sudo dnf config-manager --add-repo bintray-loadimpact-rpm.repo
        sudo dnf install --assumeyes k6
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install k6
fi
