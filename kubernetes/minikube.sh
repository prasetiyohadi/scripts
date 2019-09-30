#!/bin/sh
set -ex

mkdir -p ~/bin
curl -Lo ~/bin/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x ~/bin/minikube
