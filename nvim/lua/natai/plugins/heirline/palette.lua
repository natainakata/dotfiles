local utils_h = require("heirline.utils")
local utils = require("natai.util")
local M = {}
local colors = {
  bright_bg = utils_h.get_highlight("Folded").bg,
  bright_fg = utils_h.get_highlight("Folded").fg,
  red = utils_h.get_highlight("Keyword").fg,
  green = utils_h.get_highlight("Function").fg,
  yellow = utils_h.get_highlight("String").fg,
  blue = utils_h.get_highlight("Type").fg,
  gray = utils_h.get_highlight("NonText").fg,
  orange = utils_h.get_highlight("Constant").fg,
  purple = utils_h.get_highlight("Special").fg,
  cyan = utils_h.get_highlight("Type").fg,
  diag_warn = utils_h.get_highlight("DiagnosticWarn").fg,
  diag_error = utils_h.get_highlight("DiagnosticError").fg,
  diag_hint = utils_h.get_highlight("DiagnosticHint").fg,
  diag_info = utils_h.get_highlight("DiagnosticInfo").fg,
}
function M.init()
  utils.ensure("heirline", function(m)
    m.load_colors(colors)
  end)
end

return M
