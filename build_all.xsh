#!/usr/bin/env xonsh
import argparse
source ./test.xsh


parser = argparse.ArgumentParser("Build all")
parser.add_argument("--provider", choices=get_providers(), default="qemu.amd64")
args = parser.parse_args()


for f in g`distros/**/build.xsh`:
    ./@(f) --provider @(args.provider)
