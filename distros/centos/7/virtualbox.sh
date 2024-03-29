#!/usr/bin/env bash
set -ex

packages=(bzip2 dkms kernel-devel kernel-headers make perl gcc)
yum install -y "${packages[@]}"
mount -t auto /home/vagrant/VBoxGuestAdditions.iso /mnt
/mnt/VBoxLinuxAdditions.run install 2>&1 | tee /root/vbox_addon_install.log
umount /mnt
rm /home/vagrant/VBoxGuestAdditions.iso
