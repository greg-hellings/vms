#!/usr/bin/env bash
set -ex

# Set passwords
echo "vagrant:vagrant" | chpasswd
echo "root:vagrant" | chpasswd

# Configure vagrant user's SSH key
mkdir -m 0700 -p ~vagrant/.ssh
curl -o /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub
chmod 600 ~vagrant/.ssh/authorized_keys

# Set ownership of things vagrant should own
chown -R vagrant:wheel ~vagrant/
chown -R vagrant:wheel /etc/nixos
