distro = "debian"
version = "10"
iso = {
	url = "https://cdimage.debian.org/cdimage/archive/10.11.0/amd64/iso-cd/debian-10.11.0-amd64-netinst.iso"
	checksum = "133430141272d8bf96cfb10b6bfd1c945f5a59ea0efc2bcb56d1033c7f2866ea"
}
boot_command = [
	"<esc><wait>",
	"auto ",
	"DEBIAN_FRONTEND=text ",
	"net.ifnames=0 ",
	"biosdevnames=0 ",
	"preseed/url=http://{{.HTTPIP}}:{{ .HTTPPort }}/debian/10-preseed.cfg ",
	"console=ttyS0 ",
	"<enter>"
]
