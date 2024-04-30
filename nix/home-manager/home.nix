{ pkgs, ... }: {
  home = rec {
    username = "natai";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    bat
    lsd
    fd
    delta
    ripgrep
    tealdeer
    zoxide
    mise
    neofetch
    sheldon
    fzf
    tmux
    hyperfine
    starship
  ];
  imports = [
    ./nvim.nix
    ./git.nix
    ./dev.nix
  ];
}
