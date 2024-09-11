{ inputs, pkgs, ... }:
{
  users.users.natai = {
    packages = [
      pkgs.prismlauncher
      pkgs.protonplus
      # pkgs.polychromatic
      # pkgs.linuxKernel.packages.linux_6_6.openrazer
    ];
  };
  # hardware.openrazer.enable = true;
  # hardware.openrazer.users = [ "natai" ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          migu # ここではmiguをインストールしている
        ];
    };
  };
}
