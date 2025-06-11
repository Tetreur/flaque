{
	description = "Help me jesus";

  	inputs = {
    		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    		home-manager = {
			url = github:nix-community/home-manager;
			inputs.nixpkgs.follows = "nixpkgs";
		};

		alejandra = {
			url = "github:kamadorueda/alejandra/3.0.0";
			inputs.nixpkgs.follows = "nixpkgs";
		};
  	};

	outputs = { self, nixpkgs, alejandra, ... } @ inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				{
					environment.systemPackages = [alejandra.defaultPackage.${system}];
				}
				./hosts/nixos/configuration.nix
				inputs.home-manager.nixosModules.default
			];
		};
  	};
}
