{ config, lib, pkgs, username,...}: {
  imports = [
    ../../modules/system
  ];
  users.users."${username}" = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFWnIE5q4KWjMz5dI8YnZ7zg2zn3ZY0oie+1h2SAvZR satzin0521@gmail.com"
    ];
    shell = pkgs.zsh;
  };

}
