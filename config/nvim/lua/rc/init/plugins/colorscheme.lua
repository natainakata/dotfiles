local spec = {

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "storm",
      transparent = true,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "gbprod/nord.nvim",
    priority = 1000,
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      require("nord").setup(opts)
      vim.cmd.colorscheme("nord")
    end,
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      transparent = false,
    },
    config = function(_, opts)
      local onedark = require("onedark")
      onedark.setup(opts)
      vim.cmd.colorscheme("onedark")
      -- onedark.load()
    end,
  },
  {
    "rmehri01/onenord.nvim",
    opts = {
      disable = {
        background = true,
      },
    },
    config = function(_, opts)
      require("onenord").setup(opts)
      vim.cmd.colorscheme("onenord")
    end,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    opts = {
      flavour = "frappe",
      transparent_background = false,
      integrations = {
        aerial = true,
        noice = true,
        navic = {
          enabled = true,
        },
        notify = true,
        which_key = true,
        mason = true,
      },
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.surface2 },
          LineNr = { fg = colors.surface2 },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "default"
      vim.g.sonokai_better_performanec = 1
      vim.g.sonokai_transparent_background = 1

      vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      options = {
        transparent = true,
      },
      styles = {
        comments = "italic",
        keywords = "bold",
        types = "italic,bold",
      },
    },
    config = function(_, opts)
      require("nightfox").setup(opts)
      vim.cmd.colorscheme("nordfox")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}

return spec
