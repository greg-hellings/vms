install
text
reboot
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
