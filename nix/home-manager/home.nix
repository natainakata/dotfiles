{ pkgs, ... }:
{
  home = rec {
    username = "natai";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    vscode
    wezterm
  ];
  home.enableNixpkgsReleaseCheck = false;
  imports = [
    ./browser.nix
    ./nvim.nix
    ./git.nix
    ./dev.nix
    ./cli.nix
    ./apps.nix
  ];
}
