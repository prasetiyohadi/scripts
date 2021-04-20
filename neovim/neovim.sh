#!/usr/bin/env bash
set -euo pipefail

export OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
export OS_TYPE
export VIM_PLUG_LOCATION=${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim
export VIM_PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install neovim
install_vim_plug() {
    # install vim-plug
    # https://github.com/junegunn/vim-plug
    sh -c 'curl -fLo ${VIM_PLUG_LOCATION} --create-dirs ${VIM_PLUG_URL}'
}

install_linux() {
    if [ -f /etc/debian_version ]; then
        # remove vim
        sudo apt-get purge -y vim-tiny vim-runtime vim-common
        # install neovim
        sudo apt-get update
        sudo apt-get install -y neovim
    fi
    install_vim_plug
}

install_darwin() {
    # install neovim using brew
    which brew > /dev/null && brew install neovim
    install_vim_plug
}

configure() {
    # install neovim configuration file
    CWD=$(dirname "$0")
    mkdir -p ~/.config/nvim
    cp "$CWD/init.vim" ~/.config/nvim/init.vim
    cp "$CWD/local_bundles.vim" ~/.config/nvim/local_bundles.vim
    cp "$CWD/local_init.vim" ~/.config/nvim/local_init.vim

    # setup python virtual environment
    python3 -m venv ~/.config/nvim/env
    ~/.config/nvim/env/bin/pip install pynvim

    # install plugins
    nvim +PlugInstall +qall
}

main() {
    if [ "$OS_TYPE" == "linux-gnu" ]; then
        echo "This script will install neovim."
        if [[ -d $HOME/.config/nvim ]]; then
            read -p "$HOME/.config/nvim already exists. Replace[yn]? " -n 1 -r
            echo
            if [[ "$REPLY" =~ ^[Yy]$ ]]; then
                mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
                install_linux
                configure
            else
                echo "Installation cancelled."
            fi
        else
            install_linux
            configure
        fi
    elif [ "$OS_TYPE" == "darwin" ]; then
        echo "This script will install neovim using brew."
        if [[ -d $HOME/.config/nvim ]]; then
            read -p "$HOME/.config/nvim already exists. Replace[yn]? " -n 1 -r
            echo
            if [[ "$REPLY" =~ ^[Yy]$ ]]; then
                mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
                install_darwin
                configure
            else
                echo "Installation cancelled."
            fi
        else
            install_darwin
            configure
        fi
    fi
}

main
