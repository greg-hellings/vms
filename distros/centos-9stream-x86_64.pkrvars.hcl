distro = "centos"
version = "9stream"
iso = {
	url = "http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
	checksum = "1511402dd4b5a87be3b0a9b4b8c8f24d6cd6645f0bde76c6c4e881778a5d6648"
}
boot_command = [
  "<esc><wait>",
  "linux net.ifnames=0 biosdevnames=0 inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/centos/9stream-x86_64.ks console=ttyS0",
  "<enter>"
]
