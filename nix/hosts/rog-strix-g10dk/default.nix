{
  inputs,
  config,
  pkg,
  ...
}:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system.nix
      ../../modules/cinnamon.nix
    ]
    ++ (with inputs.nixos-hardware.nixosModules; [
      common-cpu-amd
      common-pc-ssd
    ]);
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot.enable = true;
  };
  networking.hostName = "natai-rog";
  networking.networkmanager.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
