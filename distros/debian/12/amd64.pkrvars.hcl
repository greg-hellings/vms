distro  = "debian"
version = "12"
iso = {
  url      = "http://cdimage.debian.org/cdimage/release/12.4.0/amd64/iso-cd/debian-12.4.0-amd64-netinst.iso"
  checksum = "64d727dd5785ae5fcfd3ae8ffbede5f40cca96f1580aaa2820e8b99dae989d94"
}
boot_command = [
  "<esc><wait>",
  "auto ",
  "DEBIAN_FRONTEND=text ",
  "preseed/url=http://{{.HTTPIP}}:{{ .HTTPPort }}/preseed.cfg ",
  "console=tty0 ",
  "--- net.ifnames=0 biosdevnames=0 <wait>",
  "<enter>"
]
http_directory = "distros/debian/12/http/"
