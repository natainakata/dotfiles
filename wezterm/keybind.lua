local M = {}
local wezterm = require('wezterm')
local act = wezterm.action
local utils = require('utils')

M.default_keybinds = {
  { key = ' ', mods = 'LEADER', action = act({ ShowLauncherArgs = { flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS' } }) },
  { key = 'c', mods = 'LEADER', action = 'ActivateCopyMode' },
  { key = 'x', mods = 'LEADER', action = act({ CloseCurrentPane = { confirm = true } }) },
  { key = 'p', mods = 'LEADER', action = act.PaneSelect },
  { key = 's', mods = 'LEADER', action = act({ SplitHorizontal =  { domain = 'CurrentPaneDomain' } }) },
  { key = 'v', mods = 'LEADER', action = act({ SplitVertical = { domain = 'CurrentPaneDomain' } }) },
}

M.tmux_keybinds = {
  { key = 'n', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 't', mods = 'LEADER', action = act.ShowTabNavigator },
  { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
  { key = '1', mods = 'ALT', action = act({ ActivateTab = 0 }) },
  { key = '2', mods = 'ALT', action = act({ ActivateTab = 1 }) },
  { key = '3', mods = 'ALT', action = act({ ActivateTab = 2 }) },
  { key = '4', mods = 'ALT', action = act({ ActivateTab = 3 }) },
  { key = '5', mods = 'ALT', action = act({ ActivateTab = 4 }) },
  { key = '6', mods = 'ALT', action = act({ ActivateTab = 5 }) },
  { key = '7', mods = 'ALT', action = act({ ActivateTab = 6 }) },
  { key = '8', mods = 'ALT', action = act({ ActivateTab = 7 }) },
  { key = '9', mods = 'ALT', action = act({ ActivateTab = 8 }) },
  { key = 'q', mods = 'LEADER', action = act({ CloseCurrentTab = { confirm = false } }) },
  { key = 'Enter', mods = 'LEADER', action = 'QuickSelect' },
}

function M.create_keybinds()
  return utils.merge_lists(M.default_keybinds, M.tmux_keybinds)
end

return M
