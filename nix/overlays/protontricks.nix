{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      vdf-patch = prev.python312Packages.vdf.overrideAttrs (oldAttrs: rec {
        src = inputs.vdf-patch;
      });
      protontricks-beta = prev.protontricks.overrideAttrs (oldAttrs: rec {
        src = inputs.protontricks;
        propagatedBuildInputs = [
          pkgs.python312Packages.setuptools # implicit dependency, used to find data/icon_placeholder.png
          final.vdf-patch
          pkgs.python312Packages.pillow
        ];
      });
    })
  ];
}
