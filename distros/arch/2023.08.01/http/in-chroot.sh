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
useradd vagrant -g vagrant -G wheel -d /home/vagrant
echo "vagrant:vagrant" | chpasswd

# Configure vagrant user's SSH key
mkdir -m 0700 -p ~vagrant/.ssh
cat > ~vagrant/.ssh/authorized_keys << EOKEYS
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOKEYS
chmod 600 ~vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant ~vagrant/
