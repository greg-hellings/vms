distro  = "archlinux"
version = "rolling"
iso = {
  url      = "http://dfw.mirror.rackspace.com/archlinux/iso/2023.11.01/archlinux-2023.11.01-x86_64.iso"
  checksum = "477f50617d648e46d6e326549aa56ab92115a29a97f2ca364e944cea06970608"
}
boot_command = [
  "<tab><wait> net.ifnames=0<wait> <wait>bi<wait>osdevnames=0<enter>",
  "<wait60>", # Wait for system to come up?
  "curl <wait>-o <wait>/tmp/install.sh <wait>http://{{ .HTTPIP }}<wait>:{{ .HTTPPort }}/install.sh<enter>",
  "<wait5>",
  "/usr/bin/bash <wait>/tmp/install.sh <wait>{{ .HTTPPort }} <wait>{{ .HTTPIP }}<enter>"
]
http_directory = "distros/archlinux/rolling/http/"
boot_wait      = "10s"
