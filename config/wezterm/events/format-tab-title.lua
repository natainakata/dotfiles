local wezterm = require("wezterm")
local utils = require("utils")
local M = {}

M.setup = function()
  wezterm.on("format-tab-title", function(tab, _, _, _, _, _)
    local tab_index = tab.tab_index + 1
    local title = string.format(" %d ", tab_index)
    return {
      { Text = title },
    }
  end)
end

return M
