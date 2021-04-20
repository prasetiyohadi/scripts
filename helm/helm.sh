#!/usr/bin/env bash
set -euo pipefail

export OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=`echo ${OS} | tr -d ".[:digit:]"`
export OS_TYPE
[[ "$OS_TYPE" == "darwin" ]] && export OS_TYPE=darwin-amd64
[[ "$OS_TYPE" == "linux-gnu" ]] && export OS_TYPE=linux-amd64
[[ "$OS_TYPE" == "linux-gnueabihf" ]] && export OS_TYPE=linux-arm
export HELM_VERSION=v3.5.3
export HELM_URL=https://get.helm.sh/helm-${HELM_VERSION}-${OS_TYPE}.tar.gz

# install helm
# https://helm.sh/docs/intro/install/
clean() {
    rm -rf /tmp/helm-${HELM_VERSION}-${OS_TYPE} \
        /tmp/helm-${HELM_VERSION}-${OS_TYPE}.tar.gz

}

download() {
    wget -O /tmp/helm-${HELM_VERSION}-${OS_TYPE}.tar.gz ${HELM_URL}
}

install() {
    echo 
    mkdir -p /tmp/helm-${HELM_VERSION}-${OS_TYPE}
    tar -xf /tmp/helm-${HELM_VERSION}-${OS_TYPE}.tar.gz \
        -C /tmp/helm-${HELM_VERSION}-${OS_TYPE}
    mkdir -p ~/bin
    mv /tmp/helm-${HELM_VERSION}-${OS_TYPE}/${OS_TYPE}/helm ~/bin/helm
}

# initialize a helm chart repository
# https://helm.sh/docs/intro/quickstart/
repository() {
    helm repo add stable https://charts.helm.sh/stable
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo add gitlab https://charts.gitlab.io
    helm repo add hashicorp https://helm.releases.hashicorp.com
    helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
    helm repo add jetstack https://charts.jetstack.io
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
}

main() {
    download
    install
    clean
    repository
}

if [[ "$OS_TYPE" == "linux-amd64" || "$OS_TYPE" == "linux-arm" ]]; then
    echo "This script will install helm version $HELM_VERSION."
    if [[ -s $HOME/bin/helm ]]; then
        read -p "$HOME/bin/helm already exists. Replace[yn]? " -n 1 -r
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            main
        else
            echo "Installation cancelled."
        fi
    else
        main
    fi
elif [[ "$OS_TYPE" == "darwin-amd64" ]]; then
    echo "This script will install helm version $HELM_VERSION using brew."
    which brew > /dev/null && brew install helm
fi
