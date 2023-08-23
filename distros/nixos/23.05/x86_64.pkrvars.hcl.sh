#!/usr/bin/env bash
set -exo pipefail

# Name of the file to write out
name="${0%.sh}"

version="23.05"

# Base URL
base="https://channels.nixos.org/nixos-${version}/latest-nixos-minimal-x86_64-linux.iso"

# Working directory
tmp="$(mktemp -d)"
checksums="${tmp}/checksums"

# Read the SHA256 sum value
curl -L -o "${checksums}" "${base}.sha256"
until curl -f -L -o "${checksums}" "${base}.sha256"; do
	sleep 1
done
sha="$(cat "${checksums}" | grep minimal | cut -d' ' -f 1)"

# Write out HCL file
cat << EOF > "${name}"
distro = "nixos"
version = "${version}"
iso = {
	url = "${base}"
	checksum = "${sha}"
}
boot_command = [
  "<tab><wait> net.ifnames=0<wait> <wait>bi<wait>osdevnames=0<enter>",
  "<wait60>",  # Wait for system to come up?
  "curl -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>",
  "<wait>",
  "sudo bash /tmp/install.sh {{ .HTTPPort }} {{ .HTTPIP }}<enter>"
]
http_directory = "distros/nixos/23.05/http/"
boot_wait = "5s"
EOF

rm -r "${tmp}"
