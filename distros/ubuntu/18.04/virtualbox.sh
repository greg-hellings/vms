#!/usr/bin/env bash
set -ex

apt install -y virtualbox-guest-dkms
systemctl start vboxservice
systemctl enable vboxservice
