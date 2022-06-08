#!env bash

set -exo pipefail

build="${1}"
provider=virtualbox-iso.x86_64
#provider=qemu.x86_64

packer build -on-error=ask -var headless=false -var-file distros/${build}.pkrvars.hcl -except=upload -only=${provider} sources/
vagrant box add -f --name test ${build}.box
vagrant up
vagrant ssh -c "ls -la ~/"
vagrant destroy -f
