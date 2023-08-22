#!/usr/bin/env bash
set -ex

pacman -Syyu --noconfirm

echo << EOF > /etc/ssh/sshd_config.d/00-vagrant_accept_pubkey.conf
UseDNS no
PubkeyAcceptedKeyTypes +ssh-rsa
EOF

# Clear the pacman cache
pacman -Sc --noconfirm
