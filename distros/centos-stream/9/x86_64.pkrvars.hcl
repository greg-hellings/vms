distro = "centos-stream"
version = "9"
iso = {
	url = "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
	checksum = "be2104d6deac0bf5e52e7262511b7acd3cab0dff96ddef1f2604b2de892e060d"
}
boot_command = [
  "<up><tab><wait><bs><bs><bs><bs><bs>",
  "inst.text inst.ks=cdrom:/ks.cfg console=tty0",
  "<enter><wait>"
]
cd_files = [ "distros/centos-stream/9/disc/*" ]
