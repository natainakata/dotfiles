{ pkgs, ... }:
{
  imports = [
    ../../home/core.nix
    ../../home/fcitx5
    ../../home/programs

    ./games.nix
  ];
}
