-- @type LazySpec[]
local spec = {
  {
    "rebelot/heirline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.showmode = false
      vim.opt.laststatus = 3
      local heirline = require("heirline")
      local utils = require("heirline.utils")
      local colors = {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("Keyword").fg,
        green = utils.get_highlight("Function").fg,
        yellow = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Type").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Special").fg,
        cyan = utils.get_highlight("Type").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
      }
      heirline.load_colors(colors)
      local status = require("natai.plugins.heirline.status")
      local tabline = require("natai.plugins.heirline.tab")
      heirline.setup({
        statusline = status,
        tabline = tabline,
      })
    end,
  },
}

return spec
