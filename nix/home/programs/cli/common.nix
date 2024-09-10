{
  inputs,
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    # rust variants
    bat
    lsd
    fd
    delta
    ripgrep

    # utilities
    tealdeer
    zoxide
    fastfetch
    vhs
    xclip

    # zsh environment
    sheldon
    zsh
    fzf
    tmux
    hyperfine
    starship

    # runtimes
    mise
    gcc
    go
    nodejs-slim # npmのないNode.js単体
    nodePackages.pnpm
    nodePackages.wrangler
    deno
    bun
    python312
    zig

    # language support
    nixfmt-rfc-style
    nixd
  ];

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
}
