distro = "ubuntu"
version = "18.04"
iso = {
	url = "http://cdimage.ubuntu.com/ubuntu/releases/18.04/release/ubuntu-18.04.6-server-amd64.iso"
	checksum = "f5cbb8104348f0097a8e513b10173a07dbc6684595e331cb06f93f385d0aecf6"
}
boot_command = [
	"<esc><wait1>",
	"<f6><esc><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
	"auto=true priority=critical ",
	"locale=en_US.UTF-8 ",
	"DEBIAN_FRONTEND=text ",
	"preseed/url=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/18.04/preseed.cfg ",
	"fsck.mode=skip ",
	"console=ttyS0 ",
	"console=tty0 ",
	"<enter><wait1>"
]
