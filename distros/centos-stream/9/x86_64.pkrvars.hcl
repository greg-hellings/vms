distro = "centos-stream"
version = "9"
iso = {
	url = "https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
	checksum = "2553e0812dba592ae4f73a06105eec1a285623c9ae790a5674456eed1ce9dc4c"
}
boot_command = [
  "<up><tab><wait><bs><bs><bs><bs><bs>",
  "inst.text inst.ks=cdrom:/ks.cfg console=tty0",
  "<enter><wait>"
]
cd_files = [ "distros/centos-stream/9/disc/*" ]
