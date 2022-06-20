distro = "debian"
version = "9"
iso = {
	url = "https://cdimage.debian.org/cdimage/archive/9.13.0/amd64/iso-cd/debian-9.13.0-amd64-netinst.iso"
	checksum = "71c7e9eb292acc880f84605b1ca2b997f25737fe0a43fc9586f61d35cd2eb43b"
}
boot_command = [
	"<esc><wait>",
	"auto ",
	"DEBIAN_FRONTEND=text ",
	"net.ifnames=0 ",
	"biosdevnames=0 ",
	"preseed/url=http://{{.HTTPIP}}:{{ .HTTPPort }}/debian/9-preseed.cfg ",
	"console=ttyS0 ",
	"<enter>"
]
