# Building on Windows

It's probably a good idea to have Windows Terminal installed, if you
don't already. While it's not strictly necessary, it does provide a
much better interface than the standard command prompt interface.

1. Be sure that Hyper-V is installed and enabled on your system
    * Get ahead of the curve and create an external switch called `packer-amd64` that connects directly to the external network
1. Install [Chocolatey](https://chocolatey.org/install)
    * Use Chocolatey to install packer `choco install packer`
    * Use Chooolatey to install the Windows Assessment and Development Kit's CD tooling `choco install windows-adk-oscdimg`
1. Install Python
    * From a PowerShell prompt type `python`. If it is not already installed on your system, then your Windows Store will prompt you to install it. This might require you to be in an Administrator terminal
1. Create a venv `python -m venv .venv`
1. Activate it `.\.venv\scripts\Activate.ps1`
1. Install xonsh and PyYAML `pip install xonsh PyYAML`
1. Try a build
    * You can execute directly with the `packer` executable, if you want
    * If you want to wrap up standard options, or build multiple versions/distros at once, use the `build.xsh` file
    * `xonsh build.xsh -d <distro> -b hyperv-iso.amd64 -v`
    * You can substitute out any of the options with `-a` to build "all" targets that match

### Troubleshooting

Personally, I had issues where the Hyper-V networks were untrusted by Windows. This can manifest itself as the VMs that
need to download Shell files from the Packer http server (NixOS, Archlinux, and others) being unable to reach the
HTTP server on the host. To rectify this:

1. From the Windows Start/Search type "Firewall"
1. Click "Allow an App Through The Firewall"
1. Click "Change Settings"
1. Scroll all the way down to where you find the entries for the packer-hyperv plugin
1. Ensure that all such plugin versions have the box on the left and BOTH boxes on the right checked
1. Click "Ok"
1. Try running your install again.

I also had an issue with my VMs getting a different IP address each time they booted, which means that the IP detected
during install is not the same one during provisioning. In order to address this issue I had to setup a static IP
address for the MAC address "00:00:de:ad:be:ef" in my network DHCP server and tell my machines to use external networking
to reach it.

1. Open Hyper-V Manager
1. In the right hand side, click "Virtual Switch Manager..."
1. Select the `packer-amd64` switch
1. Set connection type to 'External'
1. In your DHCP server, assign a static IP address to MAC address "00:00:de:ad:be:ef"
    1. Personally, I use dnsmasq and my subnet is 10.42.2.1/16 for DHCP, so the appropriate config line is `dhcp-host=00:00:de:ad:be:ef,10.42.2.254`
    1. The actual IP address you assign is unimportant, and if you need to spoof a different Mac address, edit the file `sources/hyperv-iso.pkr.hcl`
