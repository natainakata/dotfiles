{ inputs, pkgs, ... }:
{
  users.users.natai = {
    packages = with pkgs; [
      prismlauncher
      protonplus
      razergenie
    ];
  };
  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "natai" ];
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
