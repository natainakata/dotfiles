local utils_h = require("heirline.utils")
local utils = require("natai.utils")
local M = {}
local colors = {
  bright_bg = utils_h.get_highlight("StatusLine").bg,
  bright_fg = utils_h.get_highlight("StatusLine").fg,
  red = utils_h.get_highlight("Identifier").fg,
  green = utils_h.get_highlight("String").fg,
  yellow = utils_h.get_highlight("Type").fg,
  blue = utils_h.get_highlight("Function").fg,
  gray = utils_h.get_highlight("Comment").fg,
  orange = utils_h.get_highlight("Number").fg,
  purple = utils_h.get_highlight("Keyword").fg,
  cyan = utils_h.get_highlight("Constant").fg,
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
