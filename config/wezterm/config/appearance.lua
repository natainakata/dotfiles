local wezterm = require("wezterm")

--local color_scheme = "OneDark (base16)"
local color_scheme = "tokyonight"
-- local color_scheme = "catppuccin-frappe"
local colors = wezterm.color.get_builtin_schemes()[color_scheme]

return {
  animation_fps = 60,
  max_fps = 60,
  initial_cols = 120,
  initial_rows = 30,
  front_end = "Software",
  enable_wayland = false,
  color_scheme = color_scheme,
  background = {
    {
      source = { Color = colors.background },
      height = "100%",
      width = "100%",
      opacity = 0.85,
    },
  },
  enable_scroll_bar = false,
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  window_padding = {
    left = 5,
    right = 10,
    top = 12,
    bottom = 7,
  },
  window_frame = {
    active_titlebar_bg = "#090909",
  },
  inactive_pane_hsb = {
    saturation = 0.7,
    brightness = 0.6,
  },
  window_close_confirmation = "NeverPrompt",
}
