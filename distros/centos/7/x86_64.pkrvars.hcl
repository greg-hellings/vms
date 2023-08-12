distro = "centos"
version = "7"
iso = {
	url = "http://mirror.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-NetInstall-2009.iso"
	checksum = "b79079ad71cc3c5ceb3561fff348a1b67ee37f71f4cddfec09480d4589c191d6"
}
boot_command = [
  "<up><tab><wait>",
  "<bs><bs><bs><bs><bs> inst.ks=cdrom:/ks.cfg console=tty0",
  "<enter>"
]
cd_files = [ "distros/centos/7/disc/*" ]
