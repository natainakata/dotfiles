{ pkgs  ? import <nixpkgs>  {  }, ... }: {
  cursor = (import ./cursor.nix pkgs);
}
