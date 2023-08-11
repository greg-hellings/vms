distro = "ubuntu"
version = "20.04"
iso = {
	url = "https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso"
	checksum = "b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"
}
boot_wait = "3s"
boot_command = [
	"<enter><enter><wait1><f6><esc><wait><bs><bs><bs><bs>",
	"console=ttyS0 ",
	"console=tty0 ",
	"fsck.mode=skip ",
	"locale=en_US ",
	"auto=true ",
	"priority=critical ",
	"autoinstall ds=nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/20.04/<enter><wait>"
]
