self: super:
let
  require = path: super.callPackage( import path);
in
{
  cskk = require ./cskk { };  
  fcitx5-cskk = super.libsForQt5.callPackage (import ./fcitx5-cskk) { };
  fcitx5-cskk-qt = self.fcitx5-cskk.override { enableQt = true; };
}