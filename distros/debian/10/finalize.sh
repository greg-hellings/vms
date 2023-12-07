#!/usr/bin/env bash
set -ex

apt autoremove -y

# Configure sshd to be faster
sed -i -E -e 's,^.*(UseDNS).*$,\1 No,' /etc/ssh/sshd_config
echo "PubkeyAcceptedKeyTypes +ssh-rsa" >> /etc/ssh/sshd_config

# Clean up after ourselves
apt-get clean

virt="$(systemd-detect-virt)"
if [ "${virt}" == "microsoft" ]; then
	yum install -y hyperv-daemons
	systemctl enable hpervfcopyd
	systemctl enable hypervkvpd
	systemctl enable hypervvssd
fi