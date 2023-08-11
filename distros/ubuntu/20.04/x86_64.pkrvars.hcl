distro = "ubuntu"
version = "20.04"
iso = {
	url = "https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso"
	checksum = "b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"
}
boot_wait = "3s"
boot_command = [
	"<enter><enter><wait1><f6><esc><wait><bs><bs><bs><bs>",
	"console=tty0 ",
	"fsck.mode=skip ",
	"locale=en_US ",
	"auto=true ",
	"priority=critical ",
	"autoinstall ds=nocloud<enter><wait>"
]
cd_files = {
	"/meta-data" = ""
	"/user-data" = <<HEREDOC
#cloud-config
# vim: set ft=yaml:
autoinstall:
  version: 1
  network:  # Should disable networking, workaround for unattended-updates failing in install
    version: 2
    ethernets:
      eth0:
        match:
          name: e*
        dhcp4: yes
        dhcp6: no
  refresh-installer:
    update: no
  keyboard:
    layout: us
    toggle: null
    variant: ''
  locale: en_US.UTF-8
  identity:
    hostname: vagrant
    username: vagrant
    password: $6$rounds=4096$mJTRlY/vwPMquLe0$s4Ld3ZnvF.pM86xzbAgQD7Xpi/NMVgyQNb5CEfabFgL6nLRsP56WtwA.o.Jg/xC6HaJmM2p5fCGIo37jmKVRI0
  ssh:
    install-server: yes
    authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
    allow-pw: yes
  user-data:
    disable_root: false
    package_update: false  # These will be done by Ansible after install
    package_upgrade: false
  late-commands:
    - echo 'Defaults:vagrant !requiretty' > /target/etc/sudoers.d/vagrant
    - echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >> /target/etc/sudoers.d/vagrant
    - chmod 440 /target/etc/sudoers.d/vagrant
    - curtin in-target --target=/target -- logger "finished late-commands"
  packages:
    - ca-certificates
    - curl
    - sudo
HEREDOC
}
