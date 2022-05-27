distro = "ubuntu"
arch = "x86_64"
version = "22.04"
iso = {
	url = "https://releases.ubuntu.com/jammy/ubuntu-22.04-live-server-amd64.iso"
	checksum = "84aeaf7823c8c61baa0ae862d0a06b03409394800000b3235854a6b38eb4856f"
}
boot_wait = "15s"
boot_command = [
  "e<down><down><down><end><bs><bs><bs>",
  "console=ttyS0 ",
  "autoinstall ds=\"nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/22.04/\" console=ttyS0<F10>"
]
ssh_handshake_attempts = 1000
