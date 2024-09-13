local wezterm = require("wezterm")

local font = { family = "Moralerspace Neon", harfbuzz_features = { "calt=1", "liga=1", "dlig=1" } }
-- local font = { family = "UDEV Gothic 35NFLG", harfbuzz_features = { "calt=1", "liga=1", "dlig=1" } }
local font_size = 13

return {
  font = wezterm.font(font),
  font_size = font_size,
  command_palette_font_size = font_size,
  warn_about_missing_glyphs = false,
  adjust_window_size_when_changing_font_size = false,
  line_height = 1.2,
  freetype_load_target = "Normal",
  freetype_render_target = "Normal",
}
