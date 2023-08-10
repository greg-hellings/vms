distro = "centos"
version = "7"
iso = {
	url = "http://mirror.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-NetInstall-2009.iso"
	checksum = "b79079ad71cc3c5ceb3561fff348a1b67ee37f71f4cddfec09480d4589c191d6"
}
boot_command = [
  "<up><tab><wait>",
  "<bs><bs><bs><bs><bs> inst.ks=cdrom:/ks.cfg console=tty0",
  "<enter>"
]
cd_files = {
	"ks.cfg" = <<KICKSTART
install
text
reboot
network --bootproto=dhcp --activate
url --url=http://mirror.centos.org/centos/7/os/x86_64/
repo --name=updates --baseurl=http://mirror.centos.org/centos/7/updates/x86_64/
lang en_US.UTF-8
keyboard us
timezone --utc Etc/UTC
rootpw --plaintext vagrant
user --name=vagrant --groups=vagrant --password=vagrant --plaintext
zerombr
clearpart --all --initlabel
autopart --type=plain
bootloader --timeout=1

%packages
@core
which
libselinux-python
# mandatory packages in the @core group
-btrfs-progs
-iprutils
-kexec-tools
-plymouth
# default packages in the @core group
-*-firmware
-dracut-config-rescue
-kernel-tools
-libsysfs
-microcode_ctl
-NetworkManager*
-postfix
-rdma
%end

%post --erroronfail
yum -y update

cat <<EOF > /etc/sudoers.d/vagrant
Defaults:vagrant !requiretty
vagrant ALL=(ALL) NOPASSWD: ALL
EOF
chmod 440 /etc/sudoers.d/vagrant

ln -s /dev/null /etc/udev/rules.d/80-net-name-slot.rules
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
DEVICE="eth0"
BOOTPROTO="dhcp"
ONBOOT="yes"
TYPE="Ethernet"
EOF
%end
KICKSTART
}
