#!/usr/bin/env bash

set -ex

# Name of the file to write out
name="${0%.sh}"

baseurl="https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
checksums="$(mktemp)"
until curl -f -L -o "${checksums}" "${baseurl}.SHA256SUM"; do
	sleep 1
done
sha="$(cat "${checksums}" | awk '/SHA256/ {print $4}')"
rm "${checksums}"

cat << EOF > "${name}"
distro = "centos"
version = "9stream"
iso = {
	url = "${baseurl}"
	checksum = "${sha}"
}
boot_command = [
  "<up><tab><wait><bs><bs><bs><bs><bs>",
  "inst.text inst.ks=cdrom:/http/centos/9stream-x86_64.ks console=tty0",
  "<enter><wait>"
]
EOF
