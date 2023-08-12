distro = "fedora"
version = "rawhide"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Server/x86_64/iso/Fedora-Server-dvd-x86_64-Rawhide-20230811.n.0.iso"
	checksum = "5e369dbac97ea9abd77802dc316949bb6caa593b6a434cda93214c430a97b84e"
}
boot_command = [
  "<up>e<down><down><end><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=cdrom:/x86_64.ks console=tty0 console=ttyS0<f10>"
]
cd_files = [
	"distros/fedora/rawhide/*.ks"
]
