{
  programs = {
    firefox.enable = true;
    google-chrome.enable = true;
    vivaldi = {
      enable = true;
      commandLineArgs = [ "--enable-features=UseOzonePlatform" "--ozone-platform=wayland" "--enable-wayland-ime" ];
    };
  };
}
