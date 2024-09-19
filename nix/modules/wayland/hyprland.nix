{ pkgs, ... }:
{
  programs = {
    hyprland.enable = true;
    waybar.enable = true;
  };


  environment.systemPackages = with pkgs; [
    hyprlock
    hyprpicker
    hyprcursor
    hypridle
    hyprpaper
  ];

}
