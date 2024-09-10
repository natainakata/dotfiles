{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "natai";
  hostname = "natai-rpi";
  authorizedKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFWnIE5q4KWjMz5dI8YnZ7zg2zn3ZY0oie+1h2SAvZR satzin0521@gmail.com";
in
{

  imports = [

  ] ++ (with inputs.nixos-hardware.nixosModules; [ raspberry-pi-4 ]);
  hardware = {
    enableRedistributableFirmware = true;
    raspberry-pi."4" = {
      fkms-3d.enable = true;
      #  apply-overlays-dtmerge.enable = true;
    };
    # deviceTree = {
    #   enable = true;
    #   filter = "*rpi-4-*.dtb";
    # };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    vivaldi
    vivaldi-ffmpeg-codecs
    wezterm
    libraspberrypi
    raspberrypi-eeprom
  ];

  services.openssh.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekry";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config.allowUnfree = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };

  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = [ pkgs.fcitx5-mozc ];
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      udev-gothic-nf
      nerdfonts
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans CJK JP"
          "Noto Color Emoji"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Color Emoji"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  users = {
    mutableUsers = false;
    users."${user}" = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ authorizedKey ];
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.zsh;
    };
  };

  programs = {
    git.enable = true;
    zsh.enable = true;
  };
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
  };

  system.stateVersion = "23.11";
}
