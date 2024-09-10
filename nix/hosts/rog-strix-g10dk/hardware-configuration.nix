# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f17d3fc6-5ebd-4000-bc3a-19bf39606743";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/982C-85D4";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/a4ff10b3-2553-43a4-b0f4-14419398a805";
    fsType = "btrfs";
  };
  
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-label/Games";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=100"
      "umask=0022"
    ];
  };
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/data";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=100"
      "umask=0022"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp18s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp16s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
