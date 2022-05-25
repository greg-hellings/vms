#!env bash

set -exo pipefail

build="${1}"

packer build -var headless=false -var-file distros/${build}.pkrvars.hcl -except=upload sources/
vagrant box add -f --name test ${build}.box
vagrant up
vagrant ssh -c "ls -la ~/"
vagrant destroy -f
