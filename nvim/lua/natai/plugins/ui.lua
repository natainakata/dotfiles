return {
  {
    "folke/noice.nvim",
    dependencies = {
      {
        "rcarriga/nvim-notify",
        config = true,
      },
    },
    config = function()
      if not vim.g.neovide then
        require("noice").setup()
      end
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", "<cmd>ene<CR>"),
        dashboard.button("e", "  Browze Directory", "<cmd>Neotree<CR>"),
        dashboard.button("f", "  Find file", "<cmd>lua require('telescope.builtin').find_files({no_ignore = true, hidden = true})<CR>"),
        dashboard.button("q", "  Quit NVIM" , "<cmd>qa<CR>"),
      }
      require("alpha").setup(dashboard.config)
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        window = {
          border = "none",
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        globalstatus = true,
        section_separators = { left = ' ', right = '' },
    component_separators = { left = ' ', right = '' },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {
          { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
        hint = ' ' } },
          "encoding",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    },
  },
  {
    "akinsho/nvim-bufferline.lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      options = {
        separator_style = "thin",
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
      },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    config = true,
  },
  {
    "kevinhwang91/nvim-hlslens",
    dependencies = {
      "petertriho/nvim-scrollbar",
    },
    config = function()
      require("scrollbar.handlers.search").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "petertriho/nvim-scrollbar",
    },
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },
  "machakann/vim-highlightedyank",
}
