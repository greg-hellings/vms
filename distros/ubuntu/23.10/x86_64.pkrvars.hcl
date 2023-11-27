distro = "ubuntu"
version = "23.10"
iso = {
	url = "http://releases.ubuntu.com/23.10/ubuntu-23.10-live-server-amd64.iso"
	checksum = "d2fb80d9ce77511ed500bcc1f813e6f676d4a3577009dfebce24269ca23346a5"
}
boot_command = [
	"e<down><down><down><end><bs><bs><bs>",
	"console=tty0 ",
	"fsck.mode=skip ",
	"locale=en_US ",
	"auto=true ",
	"priority=critical ",
	"autoinstall",
	"<F10>",
]
cd_files = [
	"distros/ubuntu/23.10/disc/*"
]
