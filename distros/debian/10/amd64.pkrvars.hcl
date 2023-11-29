distro  = "debian"
version = "10"
iso = {
  url      = "https://cdimage.debian.org/cdimage/archive/10.13.0/amd64/iso-cd/debian-10.13.0-amd64-netinst.iso"
  checksum = "75aa64071060402a594dcf1e14afd669ca0f8bf757b56d4c9c1a31b8f7c8f931"
}
boot_command = [
  "<esc><wait>",
  "auto <wait>",
  "DEBIAN_FRONTEND=text <wait>",
  "preseed/url<wait>=http://{{.HTTPIP}}<wait>:{{ .HTTPPort }}/preseed.cfg <wait>",
  "console=tty0 <wait>",
  "--- <wait>net.ifnames=0 <wait>biosdevnames=0 <wait>",
  "<enter>"
]
http_directory = "distros/debian/10/http/"
