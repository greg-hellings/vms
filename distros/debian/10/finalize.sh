#!/usr/bin/env bash
set -ex

apt update
apt upgrade -y

# Configure sshd to be faster
sed -i -E -e 's,^.*(UseDNS).*$,\1 No,' /etc/ssh/sshd_config
echo "PubkeyAcceptedKeyTypes +ssh-rsa" >> /etc/ssh/sshd_config

# Clean up after ourselves
apt-get clean
