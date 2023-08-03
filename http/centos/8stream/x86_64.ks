%include /tmp/packer_ks/centos-stream/CentOS-8-Stream-x86_64-Vagrant.ks

url --mirrorlist=http://mirrorlist.centos.org/?release=8-stream&arch=x86_64&repo=BaseOS&infra=stock
repo --name=AppStream --mirrorlist=http://mirrorlist.centos.org/?release=8-stream&arch=x86_64&repo=AppStream&infra=stock
network --bootproto=dhcp --activate
reboot

%pre --interpreter /bin/bash --log /tmp/greg
set -ex
# This allows us to support virtualbox
mkdir /tmp/sr1
mount /dev/sr1 /tmp/sr1
cp -r /tmp/sr1/http /tmp/packer_ks

if [ ! -e /dev/vda ]; then
  sed -i -e 's/drives=vda/drives=sda/' -e 's/ondisk=vda/ondisk=sda/' /tmp/packer_ks/centos-stream/*
fi
%end
