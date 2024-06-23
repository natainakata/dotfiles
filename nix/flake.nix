{
  # description = "Natai Nakata Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager,  ... }@inputs:
  let
    overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
  in {
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
          {
            nixpkgs.overlays = overlays;
          }
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
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
    nixosConfigurations = {
      "natai-rpi" = inputs.nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
