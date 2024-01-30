#!/usr/bin/env bash
set -euo pipefail

OS=${OSTYPE:-'linux-gnu'}
OS_TYPE=$(echo "$OS" | tr -d ".[:digit:]")
OS_TYPE_LINUX_AMD64=x86_64-unknown-linux-gnu
[ "$OS_TYPE" == "linux-gnu" ] && export OS_TYPE=$OS_TYPE_LINUX_AMD64
APP_APIURL=https://api.github.com/repos/sharkdp/hexyl
APP_APIURL=$APP_APIURL/releases/latest
APP_BASEURL=https://github.com/sharkdp/hexyl/releases/download
APP_BIN=hexyl
APP_PATH=~/.local/bin/$APP_BIN
APP_VERSION=$(curl --silent $APP_APIURL | grep '"tag_name"' |
	sed -E 's/.*"v([^"]+)".*/\1/')
APP_SRC=${APP_BIN}-v${APP_VERSION}-${OS_TYPE}
APP_PKG=$APP_SRC.tar.gz
APP_URL=$APP_BASEURL/v$APP_VERSION/$APP_PKG

check_version() {
	$APP_BIN --version
}

download() {
	wget -O - "$APP_URL" | tar -C /tmp -zxf -
}

install() {
	mkdir -p ~/.local/bin
	mv "/tmp/$APP_SRC/$APP_BIN" $APP_PATH
}

install_linux() {
	download
	install
}

setup_linux() {
	echo "This script will install $APP_BIN version $APP_VERSION."
	if [ -s "$APP_PATH" ]; then
		check_version
		read -p "$APP_PATH already exists. Replace[yn]? " -n 1 -r
		echo
		if [[ "$REPLY" =~ ^[Yy]$ ]]; then
			install_linux
		else
			echo "Installation cancelled."
		fi
	else
		install_linux
	fi
}

main() {
	if [ "$OS_TYPE" == "$OS_TYPE_LINUX_AMD64" ]; then
		setup_linux
	fi
}

main
