distro = "centos"
version = "7"
iso = {
	url = "http://mirror.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-NetInstall-2009.iso"
	checksum = "b79079ad71cc3c5ceb3561fff348a1b67ee37f71f4cddfec09480d4589c191d6"
}
boot_command = [
  "<esc><wait>",
  "linux inst.ks=cdrom:/http/centos/7-x86_64.ks console=ttyS0",
  "<enter>"
]
