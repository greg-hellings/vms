distro = "centos-stream"
version = "9"
iso = {
	url = "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
	checksum = "3f8e83bfc1725f290609089ea923cb8fd721c8c890a9dd84b07df96ac7f0749e"
}
boot_command = [
  "<up><tab><wait><bs><bs><bs><bs><bs>",
  "inst.text inst.ks=cdrom:/ks.cfg console=tty0",
  "<enter><wait>"
]
cd_files = [ "distros/centos-stream/9/disc/*" ]
