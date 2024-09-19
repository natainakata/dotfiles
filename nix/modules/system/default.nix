{ pkgs
, lib
, username
, ...
}:
{

  imports = [
    ./locale.nix
    ./fonts.nix
    ./audio.nix
    ./fcitx5.nix
    ./wine.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekry";
      options = "--delete-older-than 7d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.dbus.packages = with pkgs; [
    xfce.xfconf
    gnome2.GConf
  ];

  programs = {
    dconf.enable = true;
    git.enable = true;
    zsh.enable = true;
    nix-ld.enable = true;
    thunar.enable = true;
    xfconf.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    sysstat
    gnumake
    xorg.xmodmap
    xdg-utils
    unzip
  ];

  services.flatpak.enable = true;
  xdg.portal.enable = true;


  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

}
