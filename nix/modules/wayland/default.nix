{ pkgs, ... }:
{
  imports = [ ./hyprland.nix ];
  environment.systemPackages = with pkgs; [
    wlogout
    wl-screenrec
    wl-clipboard
    wl-clip-persist
    rofi-wayland
    grim
    slurp
    mpv
    imv
    wev
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
