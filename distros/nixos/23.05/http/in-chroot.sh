#!/usr/bin/env bash
set -ex

# Set passwords
echo "vagrant:vagrant" | chpasswd
echo "root:vagrant" | chpasswd

# Set ownership of things vagrant should own
chown -R vagrant:vagrant ~vagrant/
chown -R vagrant:wheel /etc/nixos
