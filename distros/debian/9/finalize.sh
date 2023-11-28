#!/usr/bin/env bash
set -ex

apt update
apt upgrade -y

# Configure sshd to be faster
cat << EOF > /etc/ssh/sshd_config.d/00-vagrant_accept_pubkey.conf
UseDNS no
PubkeyAcceptedKeyTypes +ssh-rsa
EOF

# Clean up after ourselves
apt-get clean
