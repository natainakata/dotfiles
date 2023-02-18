local M = {}
local wezterm = require('wezterm')
local act = wezterm.action
local utils = require('utils')

M.default_keybinds = {
  { key = ' ', mods = 'LEADER', action = act({ ShowLauncherArgs = { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } }) },
  { key = 'Enter', mods = 'SHIFT', action = 'QuickSelect' },
  }

M.tmux_keybinds = {
  -- tab
  { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 't', mods = 'LEADER', action = act.ShowTabNavigator },
  { key = '1', mods = 'LEADER', action = act({ ActivateTab = 0 }) },
  { key = '2', mods = 'LEADER', action = act({ ActivateTab = 1 }) },
  { key = '3', mods = 'LEADER', action = act({ ActivateTab = 2 }) },
  { key = '4', mods = 'LEADER', action = act({ ActivateTab = 3 }) },
  { key = '5', mods = 'LEADER', action = act({ ActivateTab = 4 }) },
  { key = '6', mods = 'LEADER', action = act({ ActivateTab = 5 }) },
  { key = '7', mods = 'LEADER', action = act({ ActivateTab = 6 }) },
  { key = '8', mods = 'LEADER', action = act({ ActivateTab = 7 }) },
  { key = '9', mods = 'LEADER', action = act({ ActivateTab = 8 }) },
  { key = 'x', mods = 'LEADER', action = act({ CloseCurrentTab = { confirm = true } }) },
  -- pane
  { key = 'p', mods = 'LEADER', action = act.PaneSelect },
  { key = 'h', mods = 'LEADER', action = act({ ActivatePaneDirection = 'Left' }) },
  { key = 'l', mods = 'LEADER', action = act({ ActivatePaneDirection = 'Right' }) },
  { key = 'k', mods = 'LEADER', action = act({ ActivatePaneDirection = 'Up' }) },
  { key = 'j', mods = 'LEADER', action = act({ ActivatePaneDirection = 'Down' }) },
  { key = 'h', mods = 'ALT', action = act({ AdjustPaneSize = { 'Left', 5 } }) },
  { key = 'l', mods = 'ALT', action = act({ AdjustPaneSize = { 'Right', 5 } }) },
  { key = 'k', mods = 'ALT', action = act({ AdjustPaneSize = { 'Up', 5 } }) },
  { key = 'j', mods = 'ALT', action = act({ AdjustPaneSize = { 'Down', 5 } }) },
  { key = 'q', mods = 'LEADER', action = act({ CloseCurrentPane = { confirm = true } }) },
  { key = 'v', mods = 'LEADER', action = act({ SplitVertical = { domain = 'CurrentPaneDomain' } }) },
  { key = 's', mods = 'LEADER', action = act({ SplitHorizontal =  { domain = 'CurrentPaneDomain' } }) },

}

function M.create_keybinds()
  return utils.merge_lists(M.default_keybinds, M.tmux_keybinds)
end

return M
