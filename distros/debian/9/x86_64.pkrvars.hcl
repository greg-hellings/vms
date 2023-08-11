distro = "debian"
version = "9"
iso = {
	url = "https://cdimage.debian.org/cdimage/archive/9.13.0/amd64/iso-cd/debian-9.13.0-amd64-netinst.iso"
	checksum = "71c7e9eb292acc880f84605b1ca2b997f25737fe0a43fc9586f61d35cd2eb43b"
}
boot_command = [
	"<esc><wait>",
	"auto ",
	"DEBIAN_FRONTEND=text ",
	"preseed/url=http://{{.HTTPIP}}:{{ .HTTPPort }}/preseed.cfg ",
	"console=tty0 ",
	"--- ",  # Lines after this are copied to the resulting system?!
	"biosdevnames=0 ",
	"net.ifnames=0 ",
	"<enter>"
]
http_files = {
	"/preseed.cfg" = <<KICKSTART
d-i mirror/country string manual
d-i mirror/http/hostname string archive.kernel.org
d-i mirror/http/directory string /debian-archive/debian

d-i apt-setup/security_host string archive.kernel.org/debian-archive

d-i netcfg/hostname string vagrant

d-i debian-installer/locale string en_US
d-i keyboard-configuration/xkb-keymap select us

d-i passwd/root-password-again password vagrant
d-i passwd/root-password password vagrant
d-i passwd/user-fullname string vagrant
d-i passwd/username string vagrant
d-i passwd/user-password password vagrant
d-i passwd/user-password-again password vagrant

d-i time/zone string UTC

d-i partman-auto/method string regular
d-i partman-auto/expert_recipe string \
        scheme ::                     \
        200 0 200 ext4                \
                $primary{ }           \
                $bootable{ }          \
                method{ format }      \
                format{ }             \
                use_filesystem{ }     \
                filesystem{ ext4 }    \
                mountpoint{ /boot } . \
        200% 0 200% linux-swap        \
                $primary{ }           \
                method{ swap }        \
                format{ } .           \
        1 0 -1 ext4                   \
                $primary{ }           \
                method{ format }      \
                format{ }             \
                use_filesystem{ }     \
                filesystem{ ext4 }    \
                mountpoint{ / } .
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

d-i apt-setup/non-free boolean true
d-i apt-setup/contrib boolean true

tasksel tasksel/first multiselect
d-i pkgsel/include string curl openssh-server sudo python3

d-i grub-installer/bootdev string default

d-i finish-install/reboot_in_progress note

d-i preseed/early_command string                                                                                              \
        sed -i                                                                                                                \
        -e "/in-target/i echo 'd() { /sbin/discover \"\$@\" | grep -v virtualbox; }' > /target/etc/discover-pkginstall.conf"  \
        -e "/in-target/i echo 'discover=d' >> /target/etc/discover-pkginstall.conf"                                           \
        /usr/lib/pre-pkgsel.d/20install-hwpackages
d-i preseed/late_command string                                                   \
        echo 'Defaults:vagrant !requiretty' > /target/etc/sudoers.d/vagrant;      \
        echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /target/etc/sudoers.d/vagrant;  \
        chmod 440 /target/etc/sudoers.d/vagrant

KICKSTART
}