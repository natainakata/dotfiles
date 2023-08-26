local spec = {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,

    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
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
    lazy = false,
    priority = 1000,
    enabled = false,
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
          }
        end,
      },
      integrations = {
        noice = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_better_performanec = 1
      vim.g.sonokai_transparent_background = 1

      vim.cmd.colorscheme("sonokai")

    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      options = {
        transprent = true,
      },
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    enabled = false,
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
    end,
  },
}

return spec
