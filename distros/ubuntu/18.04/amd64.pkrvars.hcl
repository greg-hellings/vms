distro  = "ubuntu"
version = "18.04"
iso = {
  url      = "http://cdimage.ubuntu.com/ubuntu/releases/18.04/release/ubuntu-18.04.6-server-amd64.iso"
  checksum = "f5cbb8104348f0097a8e513b10173a07dbc6684595e331cb06f93f385d0aecf6"
}
boot_command = [
  "<esc><wait1>",
  "<f6><esc><bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "auto=true priority=critical ",
  "locale=en_US.UTF-8 ",
  "DEBIAN_FRONTEND=text ",
  "preseed/url=http://{{.HTTPIP}}:{{.HTTPPort}}/preseed.cfg ",
  "fsck.mode=skip ",
  "console=tty0 ",
  "--- net.ifnames=0 biosdevnames=0 ",
  "<enter><wait1>"
]
http_files = {
  "/preseed.cfg" = <<HEREDOC
d-i debian-installer/locale string C.UTF-8
d-i keyboard-configuration/xkb-keymap select us


d-i console-setup/ask_detect boolean false

d-i keyboard-configuration/model select USA
d-i keyboard-configuration/layout select USA
d-i keyboard-configuration/variant select USA

d-i preseed/early_command string ln -s /dev/sda /dev/vda || :
d-i grub-installer/bootdev string /dev/vda

d-i netcfg/choose_interface select auto

d-i mirror/http/mirror select us.archive.ubuntu.com
d-i mirror/http/proxy string

d-i time/zone string UTC

d-i clock-setup/utc boolean true
d-i clock-setup/utc-auto boolean true

d-i debian-installer/missing-provide select $\{DEFAULT}

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

d-i base-installer/excludes string laptop-detect

d-i passwd/root-password-again password vagrant
d-i passwd/root-password password vagrant
d-i passwd/user-fullname string vagrant
d-i passwd/username string vagrant
d-i passwd/user-password password vagrant
d-i passwd/user-password-again password vagrant
d-i user-setup/allow-password-weak boolean true

d-i pkgsel/include string curl openssh-server sudo
d-i pkgsel/language-packs multiselect
d-i pkgsel/upgrade select full-upgrade
d-i pkgsel/update-policy select none
tasksel tasksel/first multiselect ubuntu-server

d-i finish-install/reboot_in_progress note

d-i preseed/late_command string \
        echo 'Defaults:vagrant !requiretty' > /target/etc/sudoers.d/vagrant;      \
        echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /target/etc/sudoers.d/vagrant;  \
        chmod 440 /target/etc/sudoers.d/vagrant; \
        in-target update-initramfs -u
HEREDOC
}
