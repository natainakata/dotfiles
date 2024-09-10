{
  # description = "Natai Nakata Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    xremap.url = "github:xremap/nix-flake";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      homeConfigurations = {
        "natai" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [
            ./home-manager/home.nix
            { nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlays.default ]; }
          ];
        };
        "natai-rpi" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
            overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
          };
          extraSpecialArgs = {
            inherit inputs;
          };
          modules = [ ./home-manager/home.nix ];
        };
      };
      nixosConfigurations = {
        "natai-rpi" = inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ./hosts/rpi4 ];
          specialArgs = {
            inherit inputs;
          };
        };
        "natai-rog" =
          let
            username = "natai";
            specialArgs = {
              inherit username;
              inherit inputs;
            };
          in
          inputs.nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              ./hosts/rog-strix-g10dk
              ./users/${username}/nixos.nix
              (_: { nixpkgs.overlays = [ (import ./pkgs) ]; })
            ];
          };
      };
    };
}
