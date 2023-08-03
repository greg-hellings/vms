* Distro: ${distro}
* Version: ${version}
* Arch: ${arch}
* Build: ${build}
* Date: ${formatdate("DD MMM YYYY", timestamp())}
* Bugs: [vms](https://github.com/greg-hellings/vms/issues)

A bare-minimum installation of the guest OS.

If you encounter a bug in the box, please file an issue. If you
want a newer version of your desired operating system or want to add a distribution to this
collection, please either file a PR there or open a bug. If you are opening a bug, please provide
as much information as you can about how an automated installation of your desired distribution
works.

The goal is to have the bare minimum software to be considered a basic installation of the guest
OS that is still accessible with Vagrant. Straggling packages or leftover files from the build
process should be considered as bugs to be filed.
