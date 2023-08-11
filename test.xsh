#!env xonsh
# vim: set ft=xonsh:
import argparse
import pathlib
import re
import sys
import time


def get_vagrant_provider(provider):
    "Vagrant provider is not always the same as Packer provider"
    if provider.startswith("qemu"):
        return "libvirt"
    elif provider.startswith("virtualbox"):
        return "virtualbox"


def get_providers():
    "List of providers as defined in sources/"
    providers: set[str] = {
        "virtualbox-iso.x86_64",
        "qemu.x86_64"
    }
    return providers


def get_builds():
    "List of builds as supported in distros/"
    base = pathlib.Path(__file__)
    distros = base.parent / "distros"
    builds = [str(p.stem).rsplit(".", 1)[0] for p in distros.glob("**/*.pkrvars.hcl")]
    return builds


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
    for box in g`*.box`:
        sed -e f's#@@BOX@@#file:///home/greg/src/vms/vms/{box}#' -e f's/@@BOX_NAME@@/{box}/' Vagrantfile.in > Vagrantfile
        vagrant up --provider libvirt
        vagrant destroy -f
        rm -rf .vagrant


if __name__ == '__main__':
    main()
