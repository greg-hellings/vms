distro = "fedora"
version = "36"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/releases/36/Server/x86_64/iso/Fedora-Server-dvd-x86_64-36-1.5.iso"
	checksum = "5edaf708a52687b09f9810c2b6d2a3432edac1b18f4d8c908c0da6bde0379148"
}
boot_command = [
  "<up><tab><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/fedora/36-x86_64.ks console=ttyS0 <enter><wait>"
]
