local wezterm = require("wezterm")

local font = "Moralerspace Neon NF"
local font_size = 14

return {
  font = wezterm.font(font),
  font_size = font_size,
  command_palette_font_size = font_size,
  warn_about_missing_glyphs = false,
  adjust_window_size_when_changing_font_size = false,
  freetype_load_target = "Normal",
  freetype_render_target = "Normal",
}
