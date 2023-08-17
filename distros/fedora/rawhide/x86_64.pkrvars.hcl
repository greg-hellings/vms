distro = "fedora"
version = "rawhide"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Server/x86_64/iso/./Fedora-Server-dvd-x86_64-Rawhide-20230814.n.0.iso"
	checksum = "e682844d4d61e9e51b5dd98ebabb4738ed3460d02e217125c6f77f9089c87142"
}
boot_command = [
  "<up>e<down><down><end><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=cdrom:/x86_64.ks console=tty0 console=ttyS0<f10>"
]
cd_files = [
	"distros/fedora/rawhide/*.ks"
]
