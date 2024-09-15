{ inputs, pkgs, ... }:
{
  imports = [
    inputs.xremap.nixosModules.default
    ./games.nix
  ];
  users.users.natai = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFWnIE5q4KWjMz5dI8YnZ7zg2zn3ZY0oie+1h2SAvZR satzin0521@gmail.com"
    ];
    shell = pkgs.zsh;
  };
  systemd.user.services.set-xhost = {
    description = "Run a one-shot command upon user login";
    path = [ pkgs.xorg.xhost ];
    wantedBy = [ "default.target" ];
    script = "xhost +SI:localuser:root";
    environment.DISPLAY = ":0.0"; # NOTE: This is hardcoded for this flake
  };

  services.xremap = {
    userName = "natai";
    serviceMode = "system";
    withX11 = true;
    config = {
      modmap = [
        {
          name = "CapsLock disable";
          remap = {
            CapsLock = "Ctrl_L";
          };
        }
        {
          name = "Alt IME";
          remap = {
            Alt_L = {
              held = "Alt_L";
              alone = "KEY_MUHENKAN";
              alone_timeout_millis = 300;
            };
            Alt_R = {
              held = "Alt_R";
              alone = "KEY_HIRAGANA";
              alone_timeout_millis = 300;
            };
          };
          device = {
            only = "BY Tech Gaming Keyboard";
          };
        }
        {
          name = "Minecraft Razer Tarturus";
          remap = {
            KEY_1 = "KEY_F7";
            KEY_2 = "KEY_F9";
            KEY_3 = "KEY_F3";
            KEY_4 = "KEY_P";
            KEY_5 = "KEY_GRAVE";
            Alt_L = "KEY_G";
            KEY_DOWN = "KEY_B";
            KEY_UP = "KEY_J";
            KEY_LEFT = "KEY_MINUS";
            KEY_RIGHT = "KEY_EQUAL";
            KEY_TAB = "KEY_ESC";
            KEY_F = "KEY_U";
          };
          application.only = [ "/Minecraft*/" ];
          device = {
            only = "Razer Razer Tartarus V2";
          };
        }
      ];
    };
  };
}
