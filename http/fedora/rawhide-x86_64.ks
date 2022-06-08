text

%packages
# There is weirdness with the /etc/resolv.conf in the target system
# that causes some of the imported systems to fail. Hopefully this
# prevents that.
-systemd-resolved
NetworkManager
%end

%include /tmp/packer_ks/fedora/rawhide/fedora-cloud-base-vagrant.ks

%pre --interpreter /bin/bash --log /tmp/greg
cmdline=$(cat /proc/cmdline)
ks=$(printf "${cmdline}" | sed -E -e 's/.*inst\.ks=([^ ]*).*/\1/')
mkdir -p /tmp/packer_ks
cd /tmp/packer_ks
wget -m -nH "$(dirname "${ks}")"

if [ ! -e /dev/vda ]; then
  ln -s /dev/sda /dev/vda
fi
%end
