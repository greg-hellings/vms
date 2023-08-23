#!/usr/bin/env bash
set -ex

apt update
apt install -y qemu-guest-agent
systemctl start qemu-guest-agent
systemctl enable qemu-guest-agent
