#!/usr/bin/env bash
set -euo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ -f /etc/debian_version ]; then
        wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
        source /etc/os-release
        echo "deb https://repos.influxdata.com/debian $(lsb_release -cs) stable" \
            | sudo tee /etc/apt/sources.list.d/influxdb.list
        sudo apt-get update
        sudo apt-get install --assume-yes influxdb
    elif [ -f /etc/redhat-release ]; then
        cat <<EOF | sudo tee /etc/yum.repos.d/influxdb.repo
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key
EOF
        sudo dnf install --assumeyes influxdb
    fi
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install influxdb
fi
