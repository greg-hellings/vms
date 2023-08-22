# Like the Cloud Base image, but tuned for vagrant.  Enable
# the vagrant user, disable cloud-init.

# So, to be clear, this gaping security hole is an integral part of how
# Vagrant works - These images are _not_ supposed to be run in any public-
# Internet facing way - They are for use on developer setups, almost always
# with NAT
user --name=vagrant --password=vagrant

# Suggestion from @purpleidea that most/many vagrant boxes also set root PW
# to "vagrant" for ease of use.  Again, see comments above.
rootpw vagrant

# The addition of the net.ifnames=0 and biosdevnames=0 option ensures that
# even on VirtualBox virt, we get a primary network device with "eth0" as the name
# This simplifies things and allows a single disk image for both supported Vagrant
# platforms (virtualbox and kvm)
bootloader --timeout=1 --location=mbr --append="no_timer_check console=tty1 console=ttyS0,115200n8 net.ifnames=0 biosdevnames=0"

repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch

text
lang en_US.UTF-8
keyboard us
timezone --utc Etc/UTC

selinux --enforcing

firewall --disabled

services --enabled=sshd

# Configure for gpt with bios+uefi
clearpart --all --initlabel --disklabel=gpt
part prepboot  --size=4    --fstype=prepboot
part biosboot  --size=1    --fstype=biosboot
part /boot/efi --size=100  --fstype=efi
part /boot     --size=1000  --fstype=ext4 --label=boot
part btrfs.007 --size=2000 --fstype=btrfs --grow
btrfs none --label=fedora btrfs.007
btrfs /home --subvol --name=home LABEL=fedora
btrfs /     --subvol --name=root LABEL=fedora

reboot

##### begin package list #############################################
%packages --inst-langs=en

# Include packages for the cloud-server-environment group
@^cloud-server-environment

# Don't include the kernel toplevel package since it pulls in
# kernel-modules. We're happy for now with kernel-core.
-kernel
kernel-core

# Don't include dracut-config-rescue. It will have dracut generate a
# "rescue" entry in the grub menu, but that also means there is a
# rescue kernel and initramfs that get created, which (currently) add
# about another 40MiB to the /boot/ partition. Also the "rescue" mode
# is generally not useful in the cloud.
-dracut-config-rescue

# Plymouth provides a graphical boot animation. In the cloud we don't
# need a graphical boot animation. This also means anaconda won't put
# rhgb/quiet on kernel command line
-plymouth

# Install qemu-guest-agent https://pagure.io/cloud-sig/issue/319 To
# improve the integration with OpenStack and other VM management
# systems (oVirt, KubeVirt).
qemu-guest-agent


# No need for firewalld for now. We don't have a firewall on by default.
-firewalld

# Don't include the geolite2 databases, which end up with 66MiB
# in /usr/share/GeoIP
-geolite2-country
-geolite2-city
dnf-yum
rsync
fuse-sshfs
%end
##### end package list ###############################################


##### begin kickstart post ###########################################
%post --erroronfail
if [ -e /dev/vda ]; then
	device="/dev/vda"
elif [ -e /dev/sda ]; then
	device="/dev/sda"
else
	echo "No device found"
	exit 1
fi

if [ "$(arch)" = "x86_64" ]; then
# Set up legacy BIOS boot if we booted from UEFI
grub2-install --target=i386-pc "${device}"
fi

# Blivet sets pmbr_boot flag erroneously and we need to purge it
# otherwise it'll fail to boot
parted "${device}" disk_set pmbr_boot off

# linux-firmware is installed by default and is quite large. As of mid 2020:
#   Total download size: 97 M
#   Installed size: 268 M
# So far we've been fine shipping without it so let's continue.
# More discussion about this in #1234504.
echo "Removing linux-firmware package."
rpm -e linux-firmware

# See the systemd-random-seed.service man page that says:
#   " It is recommended to remove the random seed from OS images intended
#     for replication on multiple systems"
echo "Removing random-seed so it's not the same in every image."
rm -f /var/lib/systemd/random-seed

echo "Import RPM GPG key"
releasever=$(rpm --eval '%{fedora}')
basearch=$(uname -i)
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch

echo "Zeroing out empty space."
# Create zeros file with nodatacow and no compression
touch /var/tmp/zeros
chattr +C /var/tmp/zeros
# This forces the filesystem to reclaim space from deleted files
dd bs=1M if=/dev/zero of=/var/tmp/zeros || :
echo "(Don't worry -- that out-of-space error was expected.)"
# Force sync to disk (Cf. https://pagure.io/cloud-sig/issue/340#comment-743430)
btrfs filesystem sync /
rm -f /var/tmp/zeros
btrfs filesystem sync /

# When we build the image a networking config file gets left behind.
# Let's clean it up.
echo "Cleanup leftover networking configuration"
rm -f /etc/NetworkManager/system-connections/*.nmconnection

# Truncate the /etc/resolv.conf left over from NetworkManager during the
# kickstart. This causes delays in boot with cloud-init because the
# 192.168.122.1 DNS server cannot be reached.
truncate -s 0 /etc/resolv.conf

# Clear machine-id on pre generated images
truncate -s 0 /etc/machine-id

# Vagrant setup
sed -i 's,Defaults\\s*requiretty,Defaults !requiretty,' /etc/sudoers
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant-nopasswd
sed -i 's/.*UseDNS.*/UseDNS no/' /etc/ssh/sshd_config
#'k

cat > /etc/ssh/sshd_config.d/10-vagrant-insecure-rsa-key.conf <<EOF
# For now the vagrant insecure key is an rsa key
# https://github.com/hashicorp/vagrant/issues/11783
PubkeyAcceptedKeyTypes=+ssh-rsa
EOF

ssh-keygen -A

%end

##### end kickstart post ############################################
