{ config, lib, pkgs, ...}: {
  imports = [
    ../../modules/system
    ../../modules/wayland
    ../../modules/x11
  ];
}
