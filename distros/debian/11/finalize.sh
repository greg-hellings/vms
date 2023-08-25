#!/usr/bin/env bash
set -ex

apt update
apt autoremove -y
apt upgrade -y

# Configure sshd to be faster
echo << EOF > /etc/ssh/sshd_config.d/00-vagrant_accept_pubkey.conf
UseDNS no
PubkeyAcceptedKeyTypes +ssh-rsa
EOF

# Clean up after ourselves
apt-get clean
