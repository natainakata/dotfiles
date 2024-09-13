{ pkgs, ... }:
{

  programs.dconf.enable = true;
  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [
    xfce.xfconf
    gnome2.GConf
  ];

  services.xserver.displayManager.sddm = {
    enable = true;
  };
  programs = {
    hyprland.enable = true;
    waybar.enable = true;
    thunar.enable = true;
    xfconf.enable = true;
  };
  environment.systemPackages = with pkgs; [
    hyprlock
    hyprpicker
    hyprcursor
    hypridle
    hyprpaper
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
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
}
