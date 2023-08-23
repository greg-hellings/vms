#!/usr/bin/env xonsh
from argparse import ArgumentParser
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).parent / "lib"))
from support import Support, BASE
import time

source test.xsh


year, month, day, hour, minute, second, wday, jday, dst = time.localtime()
STAMP = f"build={year}.{month}.{day}.{hour}"

support = Support()
parser = ArgumentParser("Build a box")
parser.add_argument("--distro", "-d", help="Name of the distro/ folder")
parser.add_argument("--version", "-v", help="Version of the distro to build")
parser.add_argument("--build", "-b", help="Name of the target build, e.g. qemu.x86_64, virtualbox-iso.x86_64")
parser.add_argument("--list", "-l", help="List all build targets")
parser.add_argument("--all", "-a", help="Build all applicable targets", action="store_true")
parser.add_argument("--upload", "-u", help="Force doing uploads", action="store_true")
parser.add_argument("--headless", help="Run builds headless", action="store_true")
parser.add_argument("--stamp", "-s", help="Time stamp for builds", default=STAMP)
args = parser.parse_args()


# Now provide menus if we don't have defaults
def process_all():
    if args.distro:
        process_distro(support.distros[args.distro])
    else:
        for name, distro in support.distros.items():
            process_distro(distro)

def process_distro(distro):
    if args.version:
        process_builds(distro.builds_for_version(args.version))
    else:
        process_builds(distro.builds)

def process_builds(builds):
        for build in builds:
            if args.build:
                name, arch = args.build.split(".")
                if build.provider.name == name and build.provider.arch == arch:
                    do_build(build)
            else:
                do_build(build)

def do_build(build):
    if args.headless:
        headless = "headless=true"
    else:
        headless = "headless=false"

    if args.upload:
        if "VAGRANT_CLOUD_TOKEN" not in ${...}:
            print("You need to set your cloud token")
            sys.exit(1)
        packer build -var @(headless) -var @(args.stamp) @(build.var_file) @(build.only) @(BASE / "sources")
    else:
        upload = "-except=upload"
        # Skip building file if we already have built it
        output = Path(__file__).parent / "output" / get_vagrant_provider(build.provider.name) / f"{build.distro}-{build.version}-{build.provider.arch}.box"
        if output.exists():
            print(f"Skipping {build} as box already exists")
        else:
            packer build -var @(headless) -var @(args.stamp) @(build.var_file) @(build.only) -except=upload @(BASE / "sources")

if args.all or (args.distro and args.version and args.build):
    process_all()
else:
    print("Doing menu stuff")
