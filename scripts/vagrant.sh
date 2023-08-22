#!/usr/bin/env bash
set -ex

# Configure vagrant user's SSH key
mkdir -m 0700 -p ~vagrant/.ssh
curl -L -o ~vagrant/.ssh/authorized_keys "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"
chmod 600 ~vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant ~vagrant/

# Set the build time
date -Iseconds > /etc/vagrant_box_build_time
