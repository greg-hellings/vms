#!/usr/bin/env bash

set -ex

# Name of the file to write out
name="${0%.sh}"

checksums="$(mktemp)"
until curl -f -L "https://mirrors.edge.kernel.org/centos/8-stream/isos/x86_64/CHECKSUM" > "${checksums}"; do
	sleep 1
done
sha="$(grep -e latest-boot "${checksums}" | grep SHA256 | cut -d' ' -f 4)"

cat << HERPDERP > "${name}"
distro = "centos-stream"
version = "8"
iso = {
	url = "https://mirrors.edge.kernel.org/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-boot.iso"
	checksum = "${sha}"
}
boot_command = [
  "<up><tab><wait><bs><bs><bs><bs><bs>",
  "inst.text inst.ks=cdrom:/ks.cfg console=tty0",
  "<enter><wait>"
]
cd_files = [ "distros/centos-stream/8/disc/*" ]
HERPDERP
