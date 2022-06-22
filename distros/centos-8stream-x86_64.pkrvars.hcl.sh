#!/usr/bin/env bash

# Name of the file to write out
name="${0%.sh}"

checksums="$(mktemp)"
until curl -f -L -o "${checksums}" "http://mirror.centos.org/centos/8-stream/isos/x86_64/CHECKSUM"; do
	sleep 1
done
sha="$(cat "${checksums}" | grep latest-boot | grep SHA256 | cut -d' ' -f 4)"

cat << EOF > "${name}"
distro = "centos"
version = "8stream"
iso = {
	url = "http://mirror.centos.org/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-boot.iso"
	checksum = "${sha}"
}
boot_command = [
  "<esc><wait>",
  "linux net.ifnames=0 biosdevnames=0 inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/centos/8stream/x86_64.ks console=ttyS0",
  "<enter>"
]
EOF
