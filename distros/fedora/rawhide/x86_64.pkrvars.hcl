distro = "fedora"
version = "rawhide"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Server/x86_64/iso/Fedora-Server-dvd-x86_64-Rawhide-20231126.n.0.iso"
	checksum = "5613927b713cac9503a6475de95c518c9615a0aeb784b6444764a1ee0b1b69af"
}
boot_command = [
  "<up>e<down><down><end><bs><bs><bs><bs><bs>",
  "net.ifnames=0 biosdevnames=0 inst.ks=cdrom:/x86_64.ks console=tty0 console=ttyS0<f10>"
]
cd_files = [
	"distros/fedora/rawhide/*.ks"
]
