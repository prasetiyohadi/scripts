#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`
export RVM_GPG_KEYS="409B6B1796C275462A1703113804BB82D39DC0E3 \
7D2BAF1CF37B13E2069D6956105BD0E739499BDB"

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    if [ ! -d ~/.rvm ]; then
        # install rvm
        gpg2 --recv-keys $RVM_GPG_KEYS
        curl -sSL https://get.rvm.io | bash -s stable
    fi
fi
