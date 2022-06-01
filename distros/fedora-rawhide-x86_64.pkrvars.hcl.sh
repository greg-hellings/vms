#!/usr/bin/env bash
set -exo pipefail

# Name of the file to write out
name="${0%.sh}"

# Base URL
fedora=https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Server/x86_64/iso/

# Working directory
tmp="$(mktemp -d)"
listing="${tmp}/listing.html"
checksums="${tmp}/checksums"

# First, find the proper URL, since it updates every build
curl -L -o "${listing}" "${fedora}"
links="$(cat "${listing}" | pup 'a[href*=".iso"] attr{href}' | grep dvd)"
iso_name="$(echo "${links}" | grep -e 'iso$')"
iso="${fedora}${iso_name}"

# Read the SHA256 sum value
sums="$(cat "${listing}" | pup 'a[href*="CHECKSUM"] attr{href}')"
until curl -f -L -o "${checksums}" "${fedora}${sums}"; do
	sleep 1
done
sha="$(cat "${checksums}" | grep dvd | grep SHA256 | cut -d' ' -f 4)"

# Write out HCL file
cat << EOF > "${name}"
distro = "fedora"
version = "rawhide"
iso = {
	url = "${iso}"
	checksum = "${sha}"
}
boot_command = [
  "<up><tab><bs><bs><bs><bs><bs>",
  "edd=off net.ifnames=0 biosdevnames=0 inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/fedora/rawhide-x86_64.ks console=ttyS0<enter><wait>"
]
EOF

rm -r "${tmp}"
