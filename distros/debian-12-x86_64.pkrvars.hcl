distro = "debian"
version = "12"
iso = {
	url = "https://cdimage.debian.org/cdimage/archive/12.0.0/amd64/iso-cd/debian-12.0.0-amd64-netinst.iso"
	checksum = "3b0e9718e3653435f20d8c2124de6d363a51a1fd7f911b9ca0c6db6b3d30d53e"
}
boot_command = [
	"<esc><wait>",
	"auto ",
	"DEBIAN_FRONTEND=text ",
	"net.ifnames=0 ",
	"biosdevnames=0 ",
	"preseed/url=http://{{.HTTPIP}}:{{ .HTTPPort }}/debian/12-preseed.cfg ",
	"console=ttyS0 ",
	"<enter>"
]
