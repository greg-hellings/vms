distro  = "debian"
version = "12"
iso = {
  url      = "http://cdimage.debian.org/cdimage/release/12.2.0/amd64/iso-cd/debian-12.2.0-amd64-netinst.iso"
  checksum = "23ab444503069d9ef681e3028016250289a33cc7bab079259b73100daee0af66"
}
boot_command = [
  "<esc><wait>",
  "auto <wait>",
  "DEBIAN<wait>_FRONTEND<wait>=text <wait>",
  "preseed<wait>/url<wait>=http://{{.HTTPIP}}<wait>:{{ .HTTPPort }}<wait>/preseed.cfg <wait>",
  "console<wait>=tty0 <wait>",
  "--- <wait>net<wait>.ifnames<wait>=0 <wait>bios<wait>dev<wait>names=0 <wait>",
  "<enter>"
]
http_directory = "distros/debian/12/http/"
