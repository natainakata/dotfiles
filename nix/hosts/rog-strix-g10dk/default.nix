{ inputs
, config
, pkg
, ...
}:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/system
      ../../modules/x11
      ../../modules/wayland
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
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  services.xserver.displayManager.gdm.enable = true;

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
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
  boot.initrd.kernelModules = [
    "nvidia"
    # "i915"
    "nvidia_modeset"
    "nvidia_drm"
  ];
  # boot.kernelParams = [ "nvidia_drm.modeset=1" ];

    system.stateVersion = "24.05"; # Did you read the comment?
}
