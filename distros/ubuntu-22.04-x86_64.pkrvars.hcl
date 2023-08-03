distro = "ubuntu"
version = "22.04"
iso = {
	url = "https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso"
	checksum = "5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
}
boot_command = [
	"e<down><down><down><end><bs><bs><bs>",
	"fsck.mode=skip ",
	"net.ifnames=0 biosdevnames=0 ",
	"locale=en_US ",
	"auto=true ",
	"priority=critical ",
	"autoinstall ds=\"nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/22.04/\" console=tty0<F10> ",
]
