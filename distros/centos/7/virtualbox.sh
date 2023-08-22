#!/usr/bin/env bash
set -ex

packages="bzip2 dkms kernel-devel kernel-headers make perl gcc"
yum install -y ${packages}  # Intentionally not quoted
mount -t auto /home/vagrant/VBoxGuestAdditions.iso /mnt
/mnt/VBoxLinuxAdditions.run install 2>&1 | tee /root/vbox_addon_install.log
yum uninstall -y ${packages}  # Also intentionally not quoted
umount /mnt
rm /home/vagrant/VBoxGuestAdditions.iso
