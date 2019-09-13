#!/bin/bash
set -ex

export GO_VERSION=1.13

# install go
if [ -d /usr/local/go ]; then
  sudo rm -r /usr/local/go
else
  wget -O - https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | sudo tar -C /usr/local -zxf -
fi

mkdir -p $HOME/go
if [[ $SHELL =~ "zsh" ]]; then
  echo "export GOROOT=/usr/local/go" >> $HOME/.zshrc
  echo "export GOPATH=\$HOME/go" >> $HOME/.zshrc
  echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> $HOME/.zshrc
elif [[ $SHELL =~ "bash" ]]; then
  echo "export GOROOT=/usr/local/go" >> $HOME/.bashrc
  echo "export GOPATH=\$HOME/go" >> $HOME/.bashrc
  echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> $HOME/.bashrc
fi
