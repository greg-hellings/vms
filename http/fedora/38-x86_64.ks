%include /tmp/packer_ks/fedora/f38/fedora-cloud-base-vagrant.ks

text

%packages
# There is weirdness with the /etc/resolv.conf in the target system
# that causes some of the imported systems to fail. Hopefully this
# prevents that.
-systemd-resolved
NetworkManager
%end

%pre --interpreter /bin/bash --log /tmp/greg
set -ex
# This allows us to support virtualbox
mkdir /tmp/sr1
mount /dev/sr1 /tmp/sr1
cp -r /tmp/sr1/http /tmp/packer_ks

if [ ! -e /dev/vda ]; then
  ln -s /dev/sda /dev/vda
fi
%end
