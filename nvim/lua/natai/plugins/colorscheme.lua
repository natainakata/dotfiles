local spec = {
  -- {
  --   "echasnovski/mini.base16",
  --   -- priority = 1000,
  -- },
  {
    "navarasu/onedark.nvim",
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      local onedark = require("onedark")
      onedark.setup(opts)
      -- onedark.load()
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      transparent_background = true,
      highlight_overrides = {
        all = function(colors)
          return {
            CursorColumn = {
              bg = U.vary_color({ latte = U.lighten(C.mantle, 0.70, C.base) }, U.darken(C.surface0, 0.64, C.base)),
            },
            NoiceMini = {
              bg = U.vary_color({ latte = U.lighten(C.mantle, 0.70, C.base) }, U.darken(C.surface0, 0.64, C.base)),
            },
            NoiceFormatProgressTodo = {
              bg = C.surface1,
            },
          }
        end,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
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

return spec
