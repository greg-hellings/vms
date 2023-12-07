distro = "fedora"
version = "38"
iso = {
	url = "https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/x86_64/iso/Fedora-Server-dvd-x86_64-38-1.6.iso"
	checksum = "66b52d7cb39386644cd740930b0bef0a5a2f2be569328fef6b1f9b3679fdc54d"
}
boot_command = [
	"<up>e<down><down><end> ",
	"net.ifnames=0 biosdevnames=0 inst.ks=cdrom:/x86_64.ks console=tty0<f10>"
]
cd_files = [
	"distros/fedora/38/*.ks"
]
