#!/usr/bin/env bash
set -ex

apt remove cloud-init -y

apt update
apt upgrade -y

# Do some magic with init
sed -i -E -e 's,^(ACTIVE_CONSOLES="/dev/tty).*",\11,' /etc/default/console-setup

cat << EOF > /etc/ssh/sshd_config.d/00-vagrant_accept_pubkey.conf
UseDNS no
PubkeyAcceptedKeyTypes +ssh-rsa
EOF

# Clean up after ourselves
apt-get clean
