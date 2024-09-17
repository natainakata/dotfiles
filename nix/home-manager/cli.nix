{pkgs, ...}: {
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
    xclip
    helix
  ];
}
