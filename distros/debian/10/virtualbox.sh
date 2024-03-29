#!/usr/bin/env bash
set -ex

packages=(bzip2 dkms build-essential "linux-headers-$(uname -r)")
apt install -y "${packages[@]}"
mount -t auto /home/vagrant/VBoxGuestAdditions.iso /mnt
/mnt/VBoxLinuxAdditions.run install 2>&1 | tee /root/vbox_addon_install.log
apt remove -y "${packages[@]}"
umount /mnt
rm /home/vagrant/VBoxGuestAdditions.iso
