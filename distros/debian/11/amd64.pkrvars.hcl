distro = "debian"
version = "11"
iso = {
	url = "http://cdimage.debian.org/cdimage/archive/11.8.0/amd64/iso-cd/debian-11.8.0-amd64-netinst.iso"
	checksum = "d7a74813a734083df30c8d35784926deaa36bc41e5c0766388e9f591ab056b72"
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
http_directory = "distros/debian/11/http/"
