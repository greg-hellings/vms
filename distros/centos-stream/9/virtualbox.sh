#!/usr/bin/env bash
set -ex

packages="bzip2 kernel-devel kernel-headers make perl gcc"
dnf install -y ${packages}  # Intentionally not quoted
mount -t auto /home/vagrant/VBoxGuestAdditions.iso /mnt
/mnt/VBoxLinuxAdditions.run install --nox11 2>&1 | tee /root/vbox_addon_install.log
umount /mnt
rm /home/vagrant/VBoxGuestAdditions.iso
