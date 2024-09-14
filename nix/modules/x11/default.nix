{ pkgs, ... }:
{
  imports = [ ./xfce4.nix ];
  services.xserver.displayManager.startx.enable = true;
  # environment.systemPackages = with pkgs; [ xorg.xinit ];
}
