#!/usr/bin/env bash
set -ex

apt update
apt upgrade -y

# Clean up after ourselves
apt-get clean
