local utils = require("natai.util")

-- @type LazySpec[]
local spec = {
  {
    "rebelot/heirline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.showmode = false
      vim.opt.laststatus = 3
      local heirline = require("heirline")
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
