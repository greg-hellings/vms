distro  = "fedora"
version = "39"
iso = {
  url      = "https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x86_64/iso/Fedora-Server-dvd-x86_64-39-1.5.iso"
  checksum = "2755cdff6ac6365c75be60334bf1935ade838fc18de53d4c640a13d3e904f6e9"
}
boot_command = [
  "<up>e<down><down><end> ",
  "net.if<wait>names=0<wait> biosdev<wait>names=0<wait> inst.ks=<wait>cdrom:/x86_64.ks<wait> console<wait>=tty0<f10>"
]
cd_files = [
  "distros/fedora/39/*.ks"
]
