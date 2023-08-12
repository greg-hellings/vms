distro = "centos"
version = "8stream"
iso = {
	url = "http://mirror.centos.org/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-boot.iso"
	checksum = "029ead89f720becd5ee2a8cf9935aad12fda7494d61674710174b4674b357530"
}
boot_command = [
  "<up><tab><wait><bs><bs><bs><bs><bs>",
  "inst.text inst.ks=cdrom:/ks.cfg console=tty0",
  "<enter><wait>"
]
cd_files = [ "distros/centos-stream/8/disc/*" ]
