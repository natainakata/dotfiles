local M = {}
local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("utils")

M.default_keybinds = {
  {
    key = "Space",
    mods = "META",
    action = act.ShowLauncherArgs({ flags = "FUZZY|COMMANDS|DOMAINS", title = "Commands Palette" }),
  },
  -- { key = "Space", mods = "META", action = act.ActivateCommandPalette },
  { key = "f", mods = "META", action = act.ToggleFullScreen },
}

M.tmux_keybinds = {
  -- tab
  { key = "Enter", mods = "META", action = act.SpawnTab("DefaultDomain") },
  { key = "c", mods = "META", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "x", mods = "META", action = act.CloseCurrentTab({ confirm = true }) },
  { key = "t", mods = "META", action = act.ShowTabNavigator },
  { key = "[", mods = "META", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "META", action = act.ActivateTabRelative(1) },
  -- pane
  { key = "v", mods = "META", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "s", mods = "META", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "q", mods = "META", action = act.CloseCurrentPane({ confirm = true }) },

  { key = "p", mods = "META", action = act.PaneSelect },
  { key = "h", mods = "META", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "META", action = act.ActivatePaneDirection("Right") },
  { key = "k", mods = "META", action = act.ActivatePaneDirection("Up") },
  { key = "j", mods = "META", action = act.ActivatePaneDirection("Down") },
  { key = "h", mods = "SHIFT|META", action = act.AdjustPaneSize({ "Left", 5 }) },
  { key = "l", mods = "SHIFT|META", action = act.AdjustPaneSize({ "Right", 5 }) },
  { key = "k", mods = "SHIFT|META", action = act.AdjustPaneSize({ "Up", 5 }) },
  { key = "j", mods = "SHIFT|META", action = act.AdjustPaneSize({ "Down", 5 }) },
}

-- tab select
for i = 1, 8 do
  table.insert(M.tmux_keybinds, {
    key = tostring(1),
    mods = "META",
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
