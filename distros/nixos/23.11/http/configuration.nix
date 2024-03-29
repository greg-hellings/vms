{config, pkgs, lib, ...}:

{
	imports = [
		./hardware-configuration.nix
		#PROVIDER_PLACEHOLDER
	];

	system.stateVersion = "23.11";

	# Packages installed on the whole system
	environment.systemPackages = with pkgs; [
		curl
		nano
		python3
	];
	# Services that are running
	services = {
		openssh.enable = true;
		#xserver.enable = true;
	};
	# User setup
	users.groups.vagrant = {};
	users.users.vagrant = {
		isNormalUser = true;
		group = "vagrant";
		extraGroups = [ "wheel" ];
		password = "vagrant";
	};
	security.sudo.extraRules = [
		{
			users = [ "vagrant" ];
			groups = [ "vagrant" ];
			commands = [
				{ command = "ALL"; options = [ "NOPASSWD" ]; }
			];
		}
	];

	boot.loader.grub = {
		enable = true;
		devices = [ "@BOOT_DEVICE@" ];
	};
	networking = {
		hostName = "vagrant";
		networkmanager.enable = true;
		#proxy.default = "http://user:password@proxy:port/";
		#proxy.noProxy = "127.0.0.1,localhost,internal.domain";
	};
	time.timeZone = "UTC";
	
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminux16";
		keyMap = lib.mkForce "us";
		useXkbConfig = true;
	};

	nix = {
		package = pkgs.nixFlakes;
		settings = {
			experimental-features = "nix-command flakes";
		};
	};
}
