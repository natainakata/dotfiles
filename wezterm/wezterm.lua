local wezterm = require 'wezterm'

return {
  -- leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  font = wezterm.font("HackGenNerd Console"),
  use_ime = true,
  font_size = 14.0,
  color_scheme = "nightfox",
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  -- disable_default_key_bindings = true,
  tab_bar_at_bottom = true,
  default_prog = { 'wsl.exe', '--distribution', 'Ubuntu-20.04', '--exec', '/bin/zsh', '-l' },
  -- launch_menu = launch_menu,
}
