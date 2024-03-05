{pkgs, ...}: {

  home.packages = with pkgs; [
    ghq
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
