distro = "centos-stream"
version = "8"
iso = {
	url = "http://mirror.centos.org/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-boot.iso"
	checksum = "83fb6025b52ba893669575f7df0048b3adc8e66b4d7c19d8f5522651f19150ba"
}
boot_command = [
  "<up><tab><wait><bs><bs><bs><bs><bs>",
  "inst.text inst.ks=cdrom:/ks.cfg console=tty0",
  "<enter><wait>"
]
cd_files = [ "distros/centos-stream/8/disc/*" ]
