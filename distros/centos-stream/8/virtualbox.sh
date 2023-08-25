#!/usr/bin/env bash
set -ex

packages="gcc make bzip2 kernel-devel elfutils-libelf-devel"
dnf install -y ${packages}  # Intentionally not quoted
mount -t auto /home/vagrant/VBoxGuestAdditions.iso /mnt
/mnt/VBoxLinuxAdditions.run install --nox11 2>&1 | tee /root/vbox_addon_install.log
umount /mnt
rm /home/vagrant/VBoxGuestAdditions.iso
