local wezterm = require("wezterm")
local utils = require("utils")
local M = {}

M.setup = function()
  wezterm.on("update-status", function(window, pane)
    local wday = os.date("*t").wday
    local wday_ja = string.format("(%s)", utils.day_of_week_ja(wday))
    -- local title = string.format(" %s %s ", pane:get_title(), utils.basename(pane:get_current_working_dir()))
    -- local title = string.format(" %s ", pane.title)
    local date = wezterm.strftime(" 󰃮  %Y-%m-%d " .. wday_ja .. " 󰥔  %H:%M:%S")
    local name = window:active_key_table()
    if name then
      name = "TABLE: " .. name
    end
    window:set_right_status(wezterm.format({
      -- { Background = { Color = title_bg } },
      -- { Foreground = { Color = fg } },
      -- { Text = title },
      { Text = date },
      --   { Text = name },
    }))
  end)
end

return M
