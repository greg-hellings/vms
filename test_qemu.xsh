#!/usr/bin/env xonsh
source test.xsh

def main():
    # Equivalent of `set -e` in Bash
    $RAISE_SUBPROC_ERROR = True
    for distro in get_builds():
        print(f"Trying {distro}")
        ./test.xsh -b @(distro) -p qemu.x86_64 --headless
        rm -r serial-output-qemu* output_qemu* *.box
        for x in range(10):
            print("***" * 20)


if __name__ == '__main__':
    main()
