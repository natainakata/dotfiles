local M = {}
local wezterm = require("wezterm")
local act = wezterm.action

-- Show which key table is active in the status area

M.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }

M.keys = {
  {
    key = "Space",
    mods = "LEADER|SHIFT",
    action = act.ShowLauncherArgs({ flags = "FUZZY|COMMANDS", title = "Commands Palette" }),
  },
  {
    key = "Space",
    mods = "LEADER",
    action = act.ShowLauncherArgs({ flags = "FUZZY|LAUNCH_MENU_ITEMS|DOMAINS", title = "Launcher" }),
  },
  -- { key = "f", mods = "META", action = act.ToggleFullScreen },
  { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  { key = "C", mods = "CTRL", action = act.CopyTo("ClipboardAndPrimarySelection") },

  -- tab
  { key = "Enter", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "t", mods = "LEADER", action = act.ShowTabNavigator },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  -- pane
  { key = "v", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "s", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "p", mods = "LEADER", action = act.PaneSelect },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "H", mods = "LEADER", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "L", mods = "LEADER", action = act.AdjustPaneSize({ "Right", 5 }) },
  { key = "K", mods = "LEADER", action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "J", mods = "LEADER", action = act.AdjustPaneSize({ "Down", 5 }) },
}

return M
