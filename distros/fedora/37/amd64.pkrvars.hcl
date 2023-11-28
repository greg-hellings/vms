distro = "fedora"
version = "37"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/releases/37/Server/x86_64/iso/Fedora-Server-dvd-x86_64-37-1.7.iso"
	checksum = "0a4de5157af47b41a07a53726cd62ffabd04d5c1a4afece5ee7c7a84c1213e4f"
}
boot_command = [
  "<up>e<down><down><end> ",
  "net.ifnames=0 biosdevnames=0 inst.ks=cdrom:/x86_64.ks console=tty0<f10>"
]
cd_files = [
	"distros/fedora/37/*.ks"
]
