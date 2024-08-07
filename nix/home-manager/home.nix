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
    fastfetch
    sheldon
    zsh
    fzf
    tmux
    hyperfine
    starship
    vhs
  ];
  imports = [
    ./nvim.nix
    ./git.nix
    ./dev.nix
  ];
}
