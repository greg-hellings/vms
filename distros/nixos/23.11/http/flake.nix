{
	description = "A basic NixOS Vagrant install";

	inputs = {
		nixstable.url = "github:nixos/nixpkgs/nixos-23.11";
	};

	outputs = { nixstable, self, ... }@inputs:
	{
		nixosConfigurations.vagrant = nixstable.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [ ./configuration.nix ];
		};
	};
}
