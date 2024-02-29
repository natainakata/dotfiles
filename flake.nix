{
  description = "Natai Nakata Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    homeConfigurations = {
      nataiHome = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          ./home.nix
        ];
      };
    };
  };
}
