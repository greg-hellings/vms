distro = "nixos"
version = "23.05"
iso = {
	url = "https://channels.nixos.org/nixos-23.05/latest-nixos-minimal-x86_64-linux.iso"
	checksum = "e2a0bc2be3b6638692393a19435838d464149914dbd942010e31a3c8c84c82d5"
}
boot_command = [
  "<tab><wait> net.ifnames=0<wait> <wait>bi<wait>osdevnames=0<enter>",
  "<wait60>",  # Wait for system to come up?
  "curl -o /tmp/install.sh http://{{ .HTTPIP }}:{{ .HTTPPort }}/install.sh<enter>",
  "<wait>",
  "sudo bash /tmp/install.sh {{ .HTTPPort }} {{ .HTTPIP }}<enter>"
]
http_directory = "distros/nixos/23.05/http/"
boot_wait = "5s"
