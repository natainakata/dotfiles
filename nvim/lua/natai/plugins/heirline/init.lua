-- @type LazySpec[]
local spec = {
  {
    "rebelot/heirline.nvim",
    commit = "750a112",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "navarasu/onedark.nvim" },
    config = function()
      vim.opt.showmode = false
      vim.opt.laststatus = 3
      local heirline = require("heirline")
      require("natai.plugins.heirline.palette").init()
      local status = require("natai.plugins.heirline.status")
      local tabline = require("natai.plugins.heirline.tab")
      local winbar = require("natai.plugins.heirline.winbar")
      heirline.setup({
        statusline = status,
        winbar = winbar,
        tabline = tabline,
      })
    end,
  },
}
if vim.g.vscode then
  return {}
else
  return spec
end
