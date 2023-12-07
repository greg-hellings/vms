# Building on Windows

1. Be sure that Hyper-V is installed and enabled on your system
1. Download and install packer.exe to your system, and add the folder it is in to your user's PATH environment variable
1. Download the [Windows ADK](https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install) being sure to select
   at the least "Deployment Tools" from the feature set.
  1. To see more details, including a walkthrough, check [this web page](https://www.makeuseof.com/windows-iso-folder-command-prompt/)
  1. Be sure to add the install path for the Oscdimg tool to your Windows PATH.
  1. On my system, that path is "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg"
1. Open PowerShell (on my system I had to run as administrator), and ensure that you have access to python
  1. If you type "python" at the prompt and do not have it installed, it should prompt you to install from the Store
  1. Do not install the version downloaded from the Internet unless you know what you're doing
1. Create a venv `python -m venv .venv`
1. Activate it `.\.venv\scripts\Activate.ps1`
1. Install the packages in requirements-windows.txt
1. Try a build
  1. You can execute directly with the `packer` executable, if you want
  1. If you want to wrap up standard options, or build multiple versions/distros at once, use the `build.xsh` file
  1. `xonsh build.xsh -d <distro> -b hyperv-iso.amd64 -v`
  1. You can substitute out any of the options with `-a` to build "all" targets that match

### Troubleshooting

Personally, I had issues where the Hyper-V networks were untrusted by Windows. This can manifest itself as the VMs that
need to download Shell files from the Packer http server (NixOS, Archlinux, and others) being unable to reach the
HTTP server on the host. To rectify this:

1. From the Windows Start/Search type "Firewall"
1. Click "Allow and App Through The Firewall"
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
1. Select the `packer-x86_64` switch
1. Set connection type to 'External'
1. In your DHCP server, assign a static IP address to MAC address "00:00:de:ad:be:ef"
  1. Personally, I use dnsmasq and my subnet is 10.42.2.1/16 for DHCP, so the appropriate config line is `dhcp-host=00:00:de:ad:be:ef,10.42.2.254`
  1. The actual IP address you assign is unimportant, and if you need to spoof a different Mac address, edit the file `sources/hyperv-iso.pkr.hcl`
