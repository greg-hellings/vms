#!/usr/bin/env bash

# Name of the file to write out
name="${0%.sh}"

checksums="$(mktemp)"
until curl -f -L -o "${checksums}" "http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso.SHA256SUM"; do
	sleep 1
done
sha="$(cat "${checksums}" | grep SHA256 | cut -d' ' -f 4)"

cat << EOF > "${name}"
distro = "centos"
version = "9stream"
iso = {
	url = "http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
	checksum = "${sha}"
}
boot_command = [
  "<esc><wait>",
  "linux net.ifnames=0 biosdevnames=0 inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/centos/9stream-x86_64.ks console=ttyS0",
  "<enter>"
]
EOF
