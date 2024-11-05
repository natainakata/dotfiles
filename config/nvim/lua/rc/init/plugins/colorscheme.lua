local transparent = function()
  if vim.g.neovide == nil then
    return { nvim = true, vim = 1 }
  else
    return { nvim = false, vim = 0 }
  end
end

local spec = {

  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      style = "storm",
      transparent = transparent().nvim,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
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
      transparent = transparent().nvim,
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
      transparent = transparent().nvim,
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
        background = transparent().nvim,
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
      transparent_background = transparent().nvim,
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
      vim.g.sonokai_transparent_background = transparent().vim

      vim.cmd.colorscheme("sonokai")
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      options = {
        transparent = transparent().nvim,
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
      transparent = transparent().nvim,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}

return spec
