#!/usr/bin/env bash
set -ex

disk="${1}"

# Set locale info to reasonable defaults
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
sed -i -E -e 's/#(en_US.UTF-8 UTF-8)/\1/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=en" > /etc/vconsole.conf

echo "vagrant" > /etc/hostname

# Configure systems
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant-nopasswd
echo 'Defaults !requiretty' >> /etc/sudoers
sed -i 's/.*UseDNS.*/UseDNS no/' /etc/ssh/sshd_config
cat > /etc/ssh/sshd_config.d/10-vagrant-insecure-rsa-key.conf <<EOF
# For now the vagrant insecure key is an rsa key
# https://github.com/hashicorp/vagrant/issues/11783
PubkeyAcceptedKeyTypes=+ssh-rsa
EOF
ssh-keygen -A
systemctl enable sshd
systemctl enable NetworkManager

# Configure and install grub
sed -i -E -e 's/GRUB_CMDLINE_LINUX="(.*)"/GRUB_CMDLINE_LINUX="\1 net.ifnames=0 biosdevnames=0"/' /etc/default/grub
grub-install --target=i386-pc "${disk}"
grub-mkconfig -o /boot/grub/grub.cfg


# Create and configure the vagrant user
groupadd vagrant
useradd vagrant -g vagrant -G wheel -m
[ -d /home/vagrant ] || exit 1
echo "vagrant:vagrant" | chpasswd
