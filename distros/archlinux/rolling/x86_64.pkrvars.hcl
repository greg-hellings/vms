distro = "archlinux"
version = "rolling"
iso = {
	url = "http://dfw.mirror.rackspace.com/archlinux/iso/2023.08.01/archlinux-x86_64.iso"
	checksum = "3bf1287333de5c26663b70a17ce7573f15dc60780b140cbbd1c720338c0abac5"
}
boot_command = [
  "<tab><wait> net.ifnames=0<wait> <wait>bi<wait>osdevnames=0<enter>",
  "<wait60>",  # Wait for system to come up?
  "curl -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>",
  "<wait5>",
  "/usr/bin/bash /tmp/install.sh {{ .HTTPPort }}<enter>"
]
http_directory = "distros/archlinux/rolling/http/"
boot_wait = "10s"
