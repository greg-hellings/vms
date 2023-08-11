#!/usr/bin/env bash

virsh -q vol-list default | awk '{print $1}' | xargs -r -L 1 virsh vol-delete --pool default
sudo virsh -q vol-list default | awk '{print $1}' | sudo xargs -r -L 1 virsh vol-delete --pool default
vagrant box list | awk '{print $1}' | xargs -r -L 1 vagrant box remove
