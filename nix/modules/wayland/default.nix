{ pkgs, ... }:
{
  imports = [ ./hyprland.nix ];
  environment.systemPackages = with pkgs; [
    wlogout
    wl-screenrec
    wl-clipboard
    wl-clip-persist
    rofi-wayland
    xdg-utils
    grim
    slurp
    mpv
    imv
    wev
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
}
