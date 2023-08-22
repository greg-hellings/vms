#!/usr/bin/env bash
set -ex

apt install -y virtualbox-guest-utils
systemctl start vboxservice
systemctl enable vboxservice
