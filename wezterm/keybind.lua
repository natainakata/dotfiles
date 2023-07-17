local M = {}
local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

M.default_keybinds = {
  { key = "Space", mods = "ALT", action = act({ ShowLauncherArgs = { flags = "FUZZY|TABS|LAUNCH_MENU_ITEMS" } }) },
  { key = "f", mods = "ALT", action = act.ToggleFullScreen },
}

M.tmux_keybinds = {
  -- tab
  { key = "c", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "x", mods = "ALT", action = act({ CloseCurrentTab = { confirm = true } }) },

  { key = "t", mods = "ALT", action = act.ShowTabNavigator },
  { key = "1", mods = "ALT", action = act({ ActivateTab = 0 }) },
  { key = "2", mods = "ALT", action = act({ ActivateTab = 1 }) },
  { key = "3", mods = "ALT", action = act({ ActivateTab = 2 }) },
  { key = "4", mods = "ALT", action = act({ ActivateTab = 3 }) },
  { key = "5", mods = "ALT", action = act({ ActivateTab = 4 }) },
  { key = "6", mods = "ALT", action = act({ ActivateTab = 5 }) },
  { key = "7", mods = "ALT", action = act({ ActivateTab = 6 }) },
  { key = "8", mods = "ALT", action = act({ ActivateTab = 7 }) },
  { key = "9", mods = "ALT", action = act({ ActivateTab = 8 }) },
  -- pane

  { key = "v", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "s", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  { key = "q", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },

  { key = "p", mods = "ALT", action = act.PaneSelect },
  { key = "h", mods = "ALT", action = act({ ActivatePaneDirection = "Left" }) },
  { key = "l", mods = "ALT", action = act({ ActivatePaneDirection = "Right" }) },
  { key = "k", mods = "ALT", action = act({ ActivatePaneDirection = "Up" }) },
  { key = "j", mods = "ALT", action = act({ ActivatePaneDirection = "Down" }) },
  { key = "h", mods = "SHIFT|ALT", action = act({ AdjustPaneSize = { "Left", 5 } }) },
  { key = "l", mods = "SHIFT|ALT", action = act({ AdjustPaneSize = { "Right", 5 } }) },
  { key = "k", mods = "SHIFT|ALT", action = act({ AdjustPaneSize = { "Up", 5 } }) },
  { key = "j", mods = "SHIFT|ALT", action = act({ AdjustPaneSize = { "Down", 5 } }) },
}
function M.create_keybinds()
  return utils.merge_lists(M.default_keybinds, M.tmux_keybinds)
end

return M
