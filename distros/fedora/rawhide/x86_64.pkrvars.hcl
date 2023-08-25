distro = "fedora"
version = "rawhide"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Server/x86_64/iso/./Fedora-Server-dvd-x86_64-Rawhide-20230824.n.0.iso"
	checksum = "70f626198b172da63fb991e61dd571ab2be66e2f7d0795f4c14c6c52a33f57df"
}
boot_command = [
  "<up>e<down><down><end><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=cdrom:/x86_64.ks console=tty0 console=ttyS0<f10>"
]
cd_files = [
	"distros/fedora/rawhide/*.ks"
]
