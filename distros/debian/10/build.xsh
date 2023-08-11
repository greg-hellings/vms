#!/usr/bin/env xonsh
$RAISE_SUBPROC_ERROR = True
from pathlib import Path
import sys
self = Path(__file__).absolute()
base = self.parent.parent.parent.parent
source @(base / "test.xsh")


unsupported = set({
    "vagrant-iso.x86_64"
})

opts = get_parser(sys.argv[1:], unsupported)

cd @(str(base))
for provider in opts["providers"]:
    packer build -var=@(opts["headless"]) -var-file=@(self.parent / "x86_64.pkrvars.hcl") @(opts["upload"]) -only=@(provider) @(base / "sources")
