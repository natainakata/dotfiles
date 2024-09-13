{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-cskk
      fcitx5-cskk-qt
      fcitx5-gtk
      libsForQt5.fcitx5-qt
    ];
  };
  environment.systemPackages = with pkgs; [
    skk-dicts
    skktools
  ];
  services.dbus.packages = [ config.i18n.inputMethod.package ];
  environment.variables = {
    QT_IM_MODULE = "fcitx";
  };
}
