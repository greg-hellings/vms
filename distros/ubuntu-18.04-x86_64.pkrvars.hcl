distro = "ubuntu"
version = "18.04"
iso = {
	#url = "http://releases.ubuntu.com/18.04/ubuntu-18.04.6-live-server-amd64.iso"
	#checksum = "6c647b1ab4318e8c560d5748f908e108be654bad1e165f7cf4f3c1fc43995934"
	url = "http://cdimage.ubuntu.com/ubuntu/releases/18.04/release/ubuntu-18.04.6-server-amd64.iso"
	checksum = "f5cbb8104348f0097a8e513b10173a07dbc6684595e331cb06f93f385d0aecf6"
}
boot_command = [
	"<esc><wait1>",
	"<f6><esc><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
	"auto=true priority=critical ",
	"DEBIAN_FRONTEND=noninteractive ",
	"preseed/url=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/18.04/preseed.cfg ",
	"fsck.mode=skip ",
	"console=ttyS0",
	"<enter><wait1>"
]
