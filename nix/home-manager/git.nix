{pkgs, ...}: {

  home.packages = with pkgs; [
    ghq
    lazygit
  ];
  programs.git = {
    enable = true;
  };

  # GitHub CLI
  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview]; # オススメ
    settings = {
      editor = "nvim";
    };
  };
}
