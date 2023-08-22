#!/usr/bin/env bash
set -ex

dnf install -y virtualbox-guest-additions
systemctl start vboxservice
systemctl enable vboxservice
