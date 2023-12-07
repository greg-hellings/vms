#!/usr/bin/env bash

set -ex

# Name of the file to write out
name="${0%.sh}"

baseurl="https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
checksums="$(mktemp)"
until curl -f -L "${baseurl}.SHA256SUM" > "${checksums}"; do
	sleep 1
done
sha="$(awk '/SHA256/ {print $4}' "${checksums}")"
rm "${checksums}"

cat << HERPDERP > "${name}"
distro = "centos-stream"
version = "9"
iso = {
	url = "${baseurl}"
	checksum = "${sha}"
}
boot_command = [
  "<up><tab><wait><bs><bs><bs><bs><bs>",
  "inst.text <wait>inst.ks=cdrom:/ks.cfg <wait>console=tty0",
  "<enter><wait>"
]
cd_files = [ "distros/centos-stream/9/disc/*" ]
HERPDERP