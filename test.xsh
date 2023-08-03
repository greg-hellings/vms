#!env xonsh
# vim: set ft=xonsh:
import argparse
import pathlib
import re
import time


def get_vagrant_provider(provider):
    "Vagrant provider is not always the same as Packer provider"
    if provider.startswith("qemu"):
        return "libvirt"
    elif provider.startswith("virtualbox"):
        return "virtualbox"


def get_providers():
    "List of providers as defined in sources/"
    providers: list[str] = [
        "virtualbox-iso.x86_64",
        "qemu.x86_64"
    ]
    return providers


def get_builds():
    "List of builds as supported in distros/"
    base = pathlib.Path(__file__)
    distros = base.parent / "distros"
    builds = [str(p.stem).rsplit(".", 1)[0] for p in distros.glob("**/*.pkrvars.hcl")]
    return builds

def main():
    # Equivalent of `set -e` in Bash
    $RAISE_SUBPROC_ERROR = True

    # Parse user arguments
    parser = argparse.ArgumentParser("Test script")
    parser.add_argument("--build", "-b", required=True, choices=get_builds())
    parser.add_argument("--provider", "-p", default="virtualbox-iso.x86_64", choices=get_providers())
    parser.add_argument("--headless", action="store_true")
    args = parser.parse_args()

    if args.headless:
        headless = "headless=true"
    else:
        headless = "headless=false"

    packer build -var @(headless) -var-file distros/@(args.build).pkrvars.hcl -except=upload -only=@(args.provider) sources/
    vagrant box add --force --name @(args.build) @(args.build).box
    sed -e f's/@@BOX@@/{args.build}/' Vagrantfile.in > Vagrantfile
    vagrant up --provider @(get_vagrant_provider(args.provider)) --provision
    vagrant ssh -c "ls -la ~/"
    vagrant destroy -f
    rm -r .vagrant


if __name__ == '__main__':
    main()
