{ pkgs, ... }:
{
  # Enable the X11 windowing system.

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;



}
