distro = "debian"
version = "10"
iso = {
	url = "https://cdimage.debian.org/cdimage/archive/10.13.0/amd64/iso-cd/debian-10.13.0-amd64-netinst.iso"
	checksum = "75aa64071060402a594dcf1e14afd669ca0f8bf757b56d4c9c1a31b8f7c8f931"
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
http_directory = "distros/debian/10/http/"
