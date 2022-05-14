local wezterm = require 'wezterm'
local utils = require 'utils'

local tmux_keybinds = {
  { key = 'c', mods = 'LEADER', action = wezterm.action({ SpawnTab = 'CurrentPaneDomain' }) },
  { key = 'q', mods = 'LEADER', action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
  { key = 'n', mods = 'LEADER', action = wezterm.action({ ActivateTabRelative = 1 }) },
  { key = 'p', mods = 'LEADER', action = wezterm.action({ ActivateTabRelative = -1 }) },
  { key = '[', mods = 'LEADER', action = 'ActivateCopyMode' },
  { key = 'p', mods = 'LEADER|SHIFT', action = wezterm.action({ PasteFrom = 'PrimarySelection' }) },
  { key = 's', mods = 'LEADER', action = wezterm.action({ SplitHorizontal = { domain = 'CurrentPaneDomain' } }) },
  { key = 'v', mods = 'LEADER', action = wezterm.action({ SplitVertical = { domain = 'CurrentPaneDomain' } }) },
  { key = 'h', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Left' }) },
  { key = 'j', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Down' }) },
  { key = 'k', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Up' }) },
  { key = 'l', mods = 'LEADER', action = wezterm.action({ ActivatePaneDirection = 'Right' }) },
  { key = 'h', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Left', 1 } }) },
  { key = 'j', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Down', 1 } }) },
  { key = 'k', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Up', 1 } }) },
  { key = 'l', mods = 'LEADER|SHIFT', action = wezterm.action({ AdjustPaneSize = { 'Right', 1 } }) },
  { key = 'x', mods = 'LEADER', action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = " ", mods = 'LEADER', action = "QuickSelect" },
}

local default_keybinds = {
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "Insert", mods = "SHIFT", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
	{ key = " ", mods = "CTRL|SHIFT", action = "QuickSelect" },
	{ key = "x", mods = "CTRL|SHIFT", action = "ActivateCopyMode" },
	{ key = "PageUp", mods = "ALT", action = wezterm.action({ ScrollByPage = -1 }) },
	{ key = "PageDown", mods = "ALT", action = wezterm.action({ ScrollByPage = 1 }) },
	{ key = "r", mods = "ALT", action = "ReloadConfiguration" },
	{ key = "x", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
  { key = "p", mods = 'CTRL|SHIFT', action = 'ShowLauncher' }
}

local function create_keybinds()
  return utils.merge_lists(default_keybinds, tmux_keybinds)
end

local colors = {
  foreground = "#c0caf5",
  background = "#1a1b26",
  cursor_bg = "#c0caf5",
  cursor_border = "#c0caf5",
  cursor_fg = "#1a1b26",
  selection_bg = "#33467C",
  selection_fg = "#c0caf5",
  ansi = {"#15161E", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6"},
  brights = {"#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5"},
}

return {
  -- leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
  font = wezterm.font("HackGenNerd Console"),
  use_ime = true,
  font_size = 13.0,
  colors = colors,
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  -- disable_default_key_bindings = true,
  tab_bar_at_bottom = true,
  default_prog = { 'wsl.exe', '--distribution', 'Ubuntu-20.04', '--exec', '/bin/zsh', '-l' },
  default_cwd = {'\\wsl$\Ubuntu-20.04\home\natai'}
  -- launch_menu = launch_menu,
}
