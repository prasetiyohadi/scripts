#!/bin/sh
set -ex

# install conda
CWD=$(dirname $0)
curl -o /tmp/conda-installer.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sha256sum -c $CWD/conda.sum
bash /tmp/conda-installer.sh
rm /tmp/conda-installer.sh

#conda info
#conda config --set auto_activate_base false
#conda env list
