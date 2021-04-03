#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d ".[:digit:]"`
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-x86_64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux-aarch64
export AWSCLI_URL=https://awscli.amazonaws.com/awscli-exe-${OS_TYPE}.zip

# install awscli
# https://aws.amazon.com/cli/
if [[ "${OS_TYPE}" == "linux-x86_64" || "${OS_TYPE}" == "linux-aarch64" ]]; then
    CWD=$(dirname $0)
    gpg --import ${CWD}/awscli.pub
    curl ${AWSCLI_URL}.sig -o /tmp/awscliv2.sig
    curl ${AWSCLI_URL} -o /tmp/awscliv2.zip
    gpg --verify /tmp/awscliv2.sig /tmp/awscliv2.zip
    unzip -d /tmp /tmp/awscliv2.zip
    sudo /tmp/aws/install
    rm -rv /tmp/aws /tmp/awscliv2.sig /tmp/awscliv2.zip
elif [ "${OS_TYPE}" == "darwin" ]; then
    which brew > /dev/null && brew install awscli
fi
