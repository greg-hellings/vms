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
links="$(pup -f "${listing}" 'a[href*=".iso"] attr{href}' | grep dvd)"
iso_name="$(echo "${links}" | grep -e 'iso$' | head -1)"
iso="${fedora}${iso_name}"

# Read the SHA256 sum value
sums="$(pup -f "${listing}" 'a[href*="CHECKSUM"] attr{href}' | head -1)"
until curl -f -L -o "${checksums}" "${fedora}${sums}"; do
	sleep 1
done
sha="$(grep -e dvd "${checksums}" | grep SHA256 | cut -d' ' -f 4)"

# Write out HCL file
cat << EOF > "${name}"
distro = "fedora"
version = "rawhide"
iso = {
	url = "${iso}"
	checksum = "${sha}"
}
boot_command = [
  "<up>e<down><down><end><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=cdrom:/x86_64.ks console=tty0 console=ttyS0<f10>"
]
cd_files = [
	"distros/fedora/rawhide/*.ks"
]
EOF

rm -r "${tmp}"
