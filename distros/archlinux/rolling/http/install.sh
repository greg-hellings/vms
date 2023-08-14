#!/usr/bin/env bash
#vim: set ft=bash:
set -ex

port="${1}"  # HTTP port that packer is running on

loadkeys en  # Probably not necessary in a script, but here we are

if [ -e /dev/vda ]; then
	disk="/dev/vda"
elif [ -e /dev/sda ]; then
	disk="/dev/sda"
else
	exit 1  # Need to teach the script which device to use in this case
fi

# The sed bit is just to strip out the extra fluff, like comments
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${disk}
  o # create new GPT partition table
  n # new
  p # primary partition
  1 # part number
    # default start
    # default to full disk
  p # print, for debugging
  r # return to normal mode
  w # write the partition table and exit
EOF
  #t # set partition type
  #1 # on partition 1
  #4 # BIOS boot

# Format and mount partitions
mkfs.ext4 "${disk}1"

mount "${disk}1" /mnt

# Bootstrap system
pacstrap -K /mnt base linux nano sudo networkmanager openssh grub python3
genfstab -L /mnt >> /mnt/etc/fstab

# Run stuff in the chroot
curl -o /mnt/in-chroot.sh http://10.0.2.2:"${port}"/in-chroot.sh
arch-chroot /mnt /usr/bin/bash /in-chroot.sh "${disk}"
rm /mnt/in-chroot.sh

reboot
