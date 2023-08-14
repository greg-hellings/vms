distro = "nixos"
version = "23.05"
iso = {
	url = "https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-x86_64-linux.iso"
	checksum = "f5df994324bc474e834200c8d641ba32492474112e95b63df3153a906ad0bca8"
}
boot_command = [
  "<tab><wait> net.ifnames=0<wait> <wait>bi<wait>osdevnames=0<enter>",
  "<wait60>",  # Wait for system to come up?
  "curl -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>",
  "<wait>",
  "sudo bash /tmp/install.sh {{ .HTTPPort }}<enter>"
]
http_directory = "distros/nixos/23.05/http/"
boot_wait = "5s"
