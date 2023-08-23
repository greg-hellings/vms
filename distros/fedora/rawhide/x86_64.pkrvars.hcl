distro = "fedora"
version = "rawhide"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Server/x86_64/iso/./Fedora-Server-dvd-x86_64-Rawhide-20230823.n.0.iso"
	checksum = "4ed35d456b51b2d27cfa083220cc0ac4b593f63db0513d69d79af622711783a6"
}
boot_command = [
  "<up>e<down><down><end><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=cdrom:/x86_64.ks console=tty0 console=ttyS0<f10>"
]
cd_files = [
	"distros/fedora/rawhide/*.ks"
]
