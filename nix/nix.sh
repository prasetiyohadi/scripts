#!/usr/bin/env bash
set -euxo pipefail

export OS=${OSTYPE:-'linux-gnu'}
export OS_TYPE=`echo ${OS} | tr -d "[:digit:]"`

if [ "${OS_TYPE}" == "linux-gnu" ]; then
    # install nix for linux
    curl -L https://nixos.org/nix/install | sh
    # activate nix environment
    . ${HOME}/.nix-profile/etc/profile.d/nix.sh
    # verify installation
    nix-env --version
    # install lorri
    # lorri need to be started as daemon `lorri daemon` in other terminal
    # or see https://github.com/target/lorri/blob/master/contrib/daemon.md
    nix-env -if https://github.com/target/lorri/archive/master.tar.gz
    # install direnv
    # setup direnv hook for your shell https://direnv.net/docs/hook.html
    nix-env -if https://github.com/direnv/direnv/archive/master.tar.gz
    # install niv
    nix-env -iA nixpkgs.niv
fi
