{ inputs, pkgs, ... }:
{
  imports = [
    inputs.xremap.nixosModules.default
    ./games.nix
  ];
  users.users.natai = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFWnIE5q4KWjMz5dI8YnZ7zg2zn3ZY0oie+1h2SAvZR satzin0521@gmail.com"
    ];
    shell = pkgs.zsh;
  };
  services.xremap = {
    userName = "natai";
    serviceMode = "system";
    config = {
      modmap = [
        {
          name = "CapsLock is disable";
          remap = {
            CapsLock = "Ctrl_L";
          };
        }
      ];
    };
  };
  
}
