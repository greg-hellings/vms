url --mirrorlist=http://mirrorlist.centos.org/?release=9-stream&arch=x86_64&repo=BaseOS&infra=stock
repo --name=AppStream --mirrorlist=http://mirrorlist.centos.org/?release=9-stream&arch=x86_64&repo=AppStream&infra=stock

%include /tmp/packer_ks/centos-stream/CentOS-9-Stream-x86_64-Vagrant.ks

%pre --interpreter /bin/bash --log /tmp/greg
# This gets us the upstream kickstarter files
cmdline=$(cat /proc/cmdline)
ks=$(printf "${cmdline}" | sed -E -e 's/.*inst\.ks=([^ ]*).*/\1/')
mkdir -p /tmp/packer_ks
cd /tmp/packer_ks
# 3 levels up!
wget -m -nH "$(dirname "$(dirname "${ks}")")"

# This allows us to support virtualbox
if [ ! -e /dev/vda ]; then
  sed -i -e 's/drives=vda/drives=sda/' -e 's/ondisk=vda/ondisk=sda/' -e 's/shutdown/reboot/' /tmp/packer_ks/centos-stream/*
fi
%end
