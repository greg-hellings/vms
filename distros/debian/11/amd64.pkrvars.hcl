distro  = "debian"
version = "11"
iso = {
  url      = "http://cdimage.debian.org/cdimage/archive/11.8.0/amd64/iso-cd/debian-11.8.0-amd64-netinst.iso"
  checksum = "d7a74813a734083df30c8d35784926deaa36bc41e5c0766388e9f591ab056b72"
}
boot_command = [
  "<esc><wait>",
  "auto <wait>",
  "DEBIAN<wait>_FRONTEND<wait>=text <wait>",
  "preseed<wait>/url<wait>=http://{{.HTTPIP}}<wait>:{{ .HTTPPort }}<wait>/preseed<wait>.cfg <wait>",
  "console<wait>=tty0 <wait>",
  "--- <wait>net<wait>.ifnames<wait>=0 <wait>bios<wait>dev<wait>names=0 <wait>",
  "<enter>"
]
http_directory = "distros/debian/11/http/"
