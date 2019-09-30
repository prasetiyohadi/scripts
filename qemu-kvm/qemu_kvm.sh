#!/bin/sh
set -ex

# install qemu-kvm
sudo apt update
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager

# add user to libvirt group
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
