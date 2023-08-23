#!/usr/bin/env bash
set -ex

sed -i -e 's,#PROVIDER_PLACEHOLDER,./guest-agent.nix,' /etc/nixos/configuration.nix
cat << EOF > /etc/nixos/guest-agent.nix
{...}:
{
	virtualisation.virtualbox.guest = {
		enable = true;
		x11 = false;
	};
}
EOF
chown vagrant:vagrant /etc/nixos/guest-agent.nix
nixos-rebuild switch
