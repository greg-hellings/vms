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
sha="$(grep -e minimal "${checksums}" | cut -d' ' -f 1)"

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
  "curl<wait> -o<wait> /tmp/install.sh<wait> http://<wait>{{ .HTTPIP }}<wait>:{{ .HTTPPort }}<wait>/install.sh<enter>",
  "<wait>",
  "sudo<wait> bash<wait> /tmp/install.sh<wait> {{ .HTTPPort }}<wait> {{ .HTTPIP }}<enter>"
]
http_directory = "distros/nixos/23.05/http/"
boot_wait = "5s"
EOF

rm -r "${tmp}"
