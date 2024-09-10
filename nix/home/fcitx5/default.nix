{ pkgs, ... }:
{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-cskk
    ];
  };
  environment.systemPackages = with pkgs; [
    skk-dicts
    skktools
  ];
}
