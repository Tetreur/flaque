{
  description = "Help me jesus";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		alejandra = {
			url = "github:kamadorueda/alejandra/4.0.0";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
    };

    deno-latest = {
      url = "github:denoland/deno";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, alejandra, home-manager, ... } @inputs: {
    overlays.default = (final: prev: {
      deno = inputs.deno-latest.packages.${prev.system}.default;
    });

		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
			  { nixpkgs.overlays = [ self.overlays.default ]; }
				{ environment.systemPackages = [alejandra.defaultPackage.${system}]; }
				./hosts/nixos/configuration.nix
				home-manager.nixosModules.default
			];
		};
  };
}
