distro = "debian"
version = "11"
iso = {
	url = "https://cdimage.debian.org/cdimage/archive/11.2.0/amd64/iso-cd/debian-11.2.0-amd64-netinst.iso"
	checksum = "45c9feabba213bdc6d72e7469de71ea5aeff73faea6bfb109ab5bad37c3b43bd"
}
boot_command = [
	"<esc><wait>",
	"auto ",
	"DEBIAN_FRONTEND=text ",
	"net.ifnames=0 ",
	"biosdevnames=0 ",
	"preseed/url=http://{{.HTTPIP}}:{{ .HTTPPort }}/debian/11-preseed.cfg ",
	"console=ttyS0 ",
	"<enter>"
]
