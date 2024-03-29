#!env xonsh
# vim: set ft=xonsh:
import argparse
import pathlib
import re
import sys
import time
from shutil import rmtree


def get_vagrant_provider(provider):
    "Vagrant provider is not always the same as Packer provider"
    if provider.startswith("qemu"):
        return "libvirt"
    elif provider.startswith("virtualbox"):
        return "virtualbox"
    elif provider.startswith("vmware"):
        return "vmware"
    elif provider.startswith("hyperv"):
        return "hyperv"
    else:
        return provider


def get_providers():
    "List of providers as defined in sources/"
    providers: set[str] = {
        "qemu.amd64"
        "virtualbox-iso.amd64",
        "vmware-iso.amd64"
    }
    return providers


def get_parser(args, unsupported=set()):
    parser = argparse.ArgumentParser("Builder")
    parser.add_argument("--headless", action="store_true")
    parser.add_argument("--upload", action="store_true")
    parser.add_argument("--provider", action="append")
    parsed = parser.parse_args(args)
    opts = {}
    if parsed.headless:
        opts["headless"] = "headless=true"
    else:
        opts["headless"] = "headless=false"
    if parsed.upload:
        opts["upload"] = ""
    else:
        opts["upload"] = "-except=upload"
    if parsed.provider:
        opts["providers"] = set(parsed.provider)
    else:
        opts["providers"] = get_providers()
    # Filter providers
    opts["providers"] -= unsupported
    return opts


def main():
    # Equivalent of `set -e` in Bash
    #$RAISE_SUBPROC_ERROR = True
    for box in g`output/**/*.box`:
        p = pathlib.Path(box)
        with open("Vagrantfile.in", "r") as fr:
            content = fr.read()
        content = content.replace("@@BOX@@", p.resolve().as_uri())
        content = content.replace("@@BOX_NAME@@", p.name)
        with open("Vagrantfile", "w") as fw:
            fw.write(content)
        vagrant box add @(box) --name @(p.name)
        if str(p.parent.name) in ["virtualbox", "libvirt", "vmware", "hyperv"]:
            vagrant up --provider @(p.parent.name)
        else:
            print(f"Now whatcha wanna go and do that for? {box}")
            continue
        vagrant destroy -f
        vag_folder = pathlib.Path(".vagrant")
        if vag_folder.exists():
            rmtree(vag_folder)


if __name__ == '__main__':
    main()
