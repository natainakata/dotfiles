{
  # description = "Natai Nakata Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    xremap.url = "github:xremap/nix-flake";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    protontricks = {
      url = "github:Matoking/protontricks/appinfo_v29";
      flake = false;
    };
    vdf-patch = {
      url = "github:Matoking/vdf/support_new_bvdf";
      flake = false;
    };
    # hyprland = {
    #   type = "git";
    #   url = "https://github.com/hyprwm/Hyprland";
    #   submodules = true;
    # };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , nixpkgs-unstable
    , nixos-wsl
    , home-manager
    , ...
    }:
    {
      homeConfigurations = {
        # for wsl2
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
              # hyprland.nixosModules.default
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
            ];
          };
        "natai-wsl" =
          let
            username = "natai";
            specialArgs = {
              inherit username;
              inherit inputs;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "x86_64-linux";
            modules = [
              nixos-wsl.nixosModules.default
              {
                system.stateVersion = "24.05";
                wsl.enable = true;
                wsl.defaultUser = username;
                wsl.useWindowsDriver = true;
              }
              ./hosts/wsl
              ./users/natai/nixos.nix
              (_: { nixpkgs.overlays = [ (import ./pkgs) ]; })
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = import ./users/${username}/home.nix;
              }
            ];
          };
      };
    };
}
