#!/usr/bin/env bash
#vim: set ft=bash:
set -ex

port="${1}"  # HTTP port that packer is running on

if [ -e /dev/vda ]; then
	disk="/dev/vda"
elif [ -e /dev/sda ]; then
	disk="/dev/sda"
else
	exit 1  # Need to teach the script which device to use in this case
fi

# The sed bit is just to strip out the extra fluff, like comments
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${disk}
  o # create new DOS partition table
  n # new
  p # primary partition
  1 # part number
    # default start
    # default to full disk
  p # print, for debugging
  w # write the partition table and exit
EOF
  #t # set partition type
  #1 # on partition 1
  #4 # BIOS boot

# Format and mount partitions
mkfs.ext4 -L root "${disk}1"

mount "${disk}1" /mnt

# Bootstrap system
nixos-generate-config --root /mnt
curl -o /mnt/etc/nixos/configuration.nix http://10.0.2.2:"${port}"/configuration.nix
sed -i -E -e "s,@BOOT_DEVICE@,${disk}," /mnt/etc/nixos/configuration.nix
sed -i -E -e 's,(.*device = "/dev/disk/).*(".*),\1by-label/root\2,' /mnt/etc/nixos/hardware-configuration.nix
nixos-install --no-root-password

# Run stuff in the chroot
curl -o /mnt/root/in-chroot.sh http://10.0.2.2:"${port}"/in-chroot.sh
nixos-enter --root /mnt -c 'bash /root/in-chroot.sh'
rm /mnt/root/in-chroot.sh

reboot
