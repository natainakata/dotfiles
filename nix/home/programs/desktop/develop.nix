{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    wezterm
  ];
}
