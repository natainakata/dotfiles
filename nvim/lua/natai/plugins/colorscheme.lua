local trans, trans_vim
if not vim.g.neovide then
  trans = true
  trans_vim = 1
else
  trans = false
  trans_vim = 0
end

local spec = {
  -- {
  --   "echasnovski/mini.base16",
  --   -- priority = 1000,
  -- },
  {
    "navarasu/onedark.nvim",
    opts = {
      transparent = trans,
    },
    config = function(_, opts)
      local onedark = require("onedark")
      onedark.setup(opts)
      onedark.load()
    end,
  },
  -- {
  --   "sainnhe/sonokai",
  --   -- priority = 1000,
  --   config = function()
  --     vim.g.sonokai_style = "default"
  --     vim.g.sonokai_better_performanec = 1
  --     vim.g.sonokai_transparent_background = trans_vim
  --     -- vim.cmd.colorscheme("sonokai")
  --   end,
  -- },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   -- priority = 1000,
  --   opts = {
  --     options = {
  --       transprent = trans,
  --     },
  --     styles = {
  --       comments = "italic",
  --       keywords = "bold",
  --       types = "italic,bold",
  --     },
  --   },
  --   config = function(_, opts)
  --     require("nightfox").setup(opts)
  --   end,
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   -- priority = 1000,
  --   opts = {
  --     transparent = trans,
  --   },
  --   config = function(_, opts)
  --     require("kanagawa").setup(opts)
  --   end,
  -- },
}

if vim.g.vscode then
  return {}
else
  return spec
end
