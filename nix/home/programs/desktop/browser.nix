{
  programs = {
    firefox.enable = true;
    google-chrome.enable = true;
    vivaldi = {
      enable = true;
      commandLineArgs = ["--enable-wayland-ime"];
    };
  };
}
