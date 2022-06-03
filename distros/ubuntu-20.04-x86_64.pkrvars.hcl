distro = "ubuntu"
version = "20.04"
iso = {
	url = "https://releases.ubuntu.com/20.04/ubuntu-20.04.4-live-server-amd64.iso"
	checksum = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
}
boot_wait = "3s"
boot_command = [
	"<enter><enter><wait1><f6><esc><wait><bs><bs><bs><bs>",
	"console=ttyS0 console=tty0 ",
	"fsck.mode=skip ",
	"autoinstall ds=nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/20.04/<enter><wait>"
]
