local wezterm = require("wezterm")
local act = wezterm.action
local platform = require("utils").platform()

local mod = {}

if platform.is_win then
  mod.SUPER = "ALT"
  mod.SUPER_REV = "ALT|CTRL"
elseif platform.is_mac then
  mod.SUPER = "SUPER"
  mod.SUPER_REV = "SUPER|CTRL"
end

local keys = {
  { key = "F1", mods = "NONE", action = "ActivateCopyMode" },
  { key = "F2", mods = "NONE", action = act.ActivateCommandPalette },
  {
    key = "p",
    mods = mod.SUPER,
    action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS|DOMAINS", title = "Launcher" }),
  },
  {
    key = "p",
    mods = mod.SUPER_REV,
    action = act.ShowLauncherArgs({ flags = "FUZZY|COMMANDS", title = "Commands Palette" }),
  },
  {
    key = "F4",
    mods = "NONE",
    action = act.ShowLauncherArgs({ flags = "FUZZY|TABS", title = "Tabs" }),
  },
  {
    key = "F4",
    mods = "CTRL",
    action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES", title = "WorkSpaces" }),
  },

  -- window
  { key = "n",   mods = mod.SUPER,     action = act.SpawnWindow },

  -- clipboard
  { key = "v",   mods = "CTRL|SHIFT",  action = act.PasteFrom("Clipboard") },
  { key = "c",   mods = "CTRL|SHIFT",  action = act.CopyTo("ClipboardAndPrimarySelection") },

  -- tab
  { key = "t",   mods = mod.SUPER,     action = act.SpawnTab("DefaultDomain") },
  { key = "t",   mods = mod.SUPER_REV, action = act.SpawnTab("CurrentPaneDomain") },
  { key = "w",   mods = mod.SUPER,     action = act.CloseCurrentTab({ confirm = false }) },
  -- { key = "t",     mods = "LEADER", action = act.ShowTabNavigator },
  { key = "[",   mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
  { key = "]",   mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
  -- pane
  { key = [[\]], mods = mod.SUPER,     action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "-",   mods = mod.SUPER,     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "x",   mods = mod.SUPER,     action = act.CloseCurrentPane({ confirm = false }) },
  {
    key = "b",
    mods = mod.SUPER,
    action = act.PaneSelect({ alphabet = "asdfghjkl", mode = "SwapWithActiveKeepFocus" }),
  },
  { key = "h", mods = mod.SUPER, action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = mod.SUPER, action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = mod.SUPER, action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = mod.SUPER, action = act.ActivatePaneDirection("Down") },

  -- key-tables --
  -- resizes fonts
  {
    key = "f",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_font",
      one_shot = false,
      timemout_miliseconds = 1000,
    }),
  },
  -- resize panes
  {
    key = "p",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_pane",
      one_shot = false,
      timemout_miliseconds = 1000,
    }),
  },
}

local key_tables = {
  resize_font = {
    { key = "k",      action = act.IncreaseFontSize },
    { key = "j",      action = act.DecreaseFontSize },
    { key = "r",      action = act.ResetFontSize },
    { key = "Escape", action = "PopKeyTable" },
    { key = "q",      action = "PopKeyTable" },
  },
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "l",      action = act.AdjustPaneSize({ "Right", 5 }) },
    { key = "k",      action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "j",      action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "q",      action = "PopKeyTable" },
  },
}

local mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CTRL",
    action = act.OpenLinkAtMouseCursor,
  },
}

return {
  disable_default_key_bindings = true,
  leader = { key = "Space", mods = mod.SUPER_REV, timeout_milliseconds = 2000 },
  keys = keys,
  key_tables = key_tables,
  mouse_bindings = mouse_bindings,
}
