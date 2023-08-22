#!/usr/bin/env bash
set -ex

pacman -Sy --noconfirm qemu-guest-agent
systemctl start qemu-guest-agent
systemctl enable qemu-guest-agent
