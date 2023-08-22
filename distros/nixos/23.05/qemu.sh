#!/usr/bin/env bash
set -ex

sed -i -e 's,#PROVIDER_PLACEHOLDER,guest-agent.nix,' /etc/nixos/configuration.nix
cat << EOF > /etc/nixos/guest-agent.nix
{...}:
{
	services.qemuGuest.enable = true;
}
EOF
chown vagrant:vagrant /etc/nixos/guest-agent.nix
nixos-rebuild switch
