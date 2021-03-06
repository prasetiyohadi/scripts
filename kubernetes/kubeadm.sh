#!/bin/sh
set -ex

if [ "$(lsb_release -is)" == "Debian" ] && [ "$(lsb_release -cs)" == "buster" ];
then
  sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
  sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
  sudo update-alternatives --set arptables /usr/sbin/arptables-legacy
  sudo update-alternatives --set ebtables /usr/sbin/ebtables-legacy
fi
