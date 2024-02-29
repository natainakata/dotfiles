{
  home = rec {
    username = "natai";
    homeDirectory = "/home/${username}";
  };
  programs.home-manager.enable = true;
}
