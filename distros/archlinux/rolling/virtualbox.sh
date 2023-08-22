#!/usr/bin/env bash
set -ex

pacman -Sy --noconfirm virtualbox-guest-utils-nox
systemctl start vboxservice
systemctl enable vboxservice
