distro  = "ubuntu"
version = "22.04"
iso = {
  url      = "https://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso"
  checksum = "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd"
}
boot_command = [
  "e<down><down><down><end><bs><bs><bs>",
  "console=tty0 <wait>",
  "fsck.mode=skip <wait>",
  "locale=en_US <wait>",
  "auto=true <wait>",
  "priority=<wait>critical <wait>",
  "autoinstall<wait>",
  "<F10>",
]
cd_files = [
  "distros/ubuntu/22.04/disc/*"
]
