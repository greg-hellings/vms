%include /tmp/packer_ks/centos-stream/CentOS-9-Stream-x86_64-Vagrant.ks

url --metalink=https://mirrors.centos.org/metalink?arch=x86_64&repo=centos-baseos-9-stream
repo --name=AppStream --metalink=https://mirrors.centos.org/metalink?arch=x86_64&repo=centos-appstream-9-stream
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
