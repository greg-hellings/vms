distro = "debian"
version = "12"
iso = {
	url = "http://cdimage.debian.org/cdimage/release/12.2.0/amd64/iso-cd/debian-12.2.0-amd64-netinst.iso"
	checksum = "23ab444503069d9ef681e3028016250289a33cc7bab079259b73100daee0af66"
}
boot_command = [
	"<esc><wait>",
	"auto ",
	"DEBIAN_FRONTEND=text ",
	"preseed/url=http://{{.HTTPIP}}:{{ .HTTPPort }}/preseed.cfg ",
	"console=tty0 ",
	"--- net.ifnames=0 biosdevnames=0 ",
	"<enter>"
]
http_directory = "distros/debian/12/http/"
