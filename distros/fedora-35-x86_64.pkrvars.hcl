distro = "fedora"
version = "35"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/releases/35/Server/x86_64/iso/Fedora-Server-dvd-x86_64-35-1.2.iso"
	checksum = "3fe521d6c7b12c167f3ac4adab14c1f344dd72136ba577aa2bcc4a67bcce2bc6"
}
boot_command = [
  "<up><tab><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/fedora/35-x86_64.ks console=ttyS0 <enter><wait>"
]
