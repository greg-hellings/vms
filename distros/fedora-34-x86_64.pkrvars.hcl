distro = "fedora"
version = "34"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/releases/34/Server/x86_64/iso/Fedora-Server-netinst-x86_64-34-1.2.iso"
	checksum = "e1a38b9faa62f793ad4561b308c31f32876cfaaee94457a7a9108aaddaeec406"
}
boot_command = [
  "<tab><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/fedora/34-x86_64.ks console=ttyS0 console=tty0<enter><wait>"
]
