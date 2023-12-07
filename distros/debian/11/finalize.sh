#!/usr/bin/env bash
set -ex

apt autoremove -y

# Configure sshd to be faster
cat << EOF > /etc/ssh/sshd_config.d/00-vagrant_accept_pubkey.conf
UseDNS no
PubkeyAcceptedKeyTypes +ssh-rsa
EOF

# Clean up after ourselves
apt-get clean

virt="$(systemd-detect-virt)"
if [ "${virt}" == "microsoft" ]; then
	yum install -y hyperv-daemons
	systemctl enable hpervfcopyd
	systemctl enable hypervkvpd
	systemctl enable hypervvssd
fi