local M = {}
local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

M.default_keybinds = {
  {
    key = "Space",
    mods = "ALT",
    action = act.ShowLauncherArgs({ flags = "FUZZY|COMMANDS|DOMAINS", title = "Commands Palette" }),
  },
  -- { key = "Space", mods = "ALT", action = act.ActivateCommandPalette },
  { key = "f", mods = "ALT", action = act.ToggleFullScreen },
}

M.tmux_keybinds = {
  -- tab
  { key = "Enter", mods = "ALT", action = act.SpawnTab("DefaultDomain") },
  { key = "c", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "x", mods = "ALT", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "t", mods = "ALT", action = act.ShowTabNavigator },
  { key = "[", mods = "ALT", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "ALT", action = act.ActivateTabRelative(1) },
  -- pane
  { key = "v", mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "s", mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "q", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },

  { key = "p", mods = "ALT", action = act.PaneSelect },
  { key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
  { key = "h", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "l", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Right", 5 }) },
  { key = "k", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "j", mods = "SHIFT|ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
}

-- tab select
for i = 1, 8 do
  table.insert(M.tmux_keybinds, {
    key = tostring(1),
    mods = "ALT",
    action = act.ActivateTab(i - 1),
  })
  table.insert(M.tmux_keybinds, {
    key = "F" .. tostring(i),
    action = act.ActivateTab(i - 1),
  })
end

function M.create_keybinds()
  return utils.merge_lists(M.default_keybinds, M.tmux_keybinds)
end

return M
