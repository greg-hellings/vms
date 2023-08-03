distro = "debian"
version = "11"
iso = {
	url = "https://cdimage.debian.org/cdimage/archive/11.7.0/amd64/iso-cd/debian-11.7.0-amd64-netinst.iso"
	checksum = "eb3f96fd607e4b67e80f4fc15670feb7d9db5be50f4ca8d0bf07008cb025766b"
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
