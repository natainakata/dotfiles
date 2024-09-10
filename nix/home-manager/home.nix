{ pkgs, ... }:
{
  home = rec {
    username = "natai";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  home.enableNixpkgsReleaseCheck = false;
  imports = [
    ./nvim.nix
    ./git.nix
    ./dev.nix
    ./cli.nix
  ];
}
