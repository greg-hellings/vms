#!/usr/bin/env bash
set -ex

yum install -y qemu-guest-agent
systemctl start qemu-guest-agent
systemctl enable qemu-guest-agent
