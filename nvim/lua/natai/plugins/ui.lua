return {
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "NormalFloat",
    },
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = "rcarriga/nvim-notify",
    enabled = function()
      if vim.g.neovide then
        return false
      end
      return true
    end,
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", "<cmd>ene<CR>"),
        dashboard.button("e", "  Browze Directory", "<cmd>Neotree<CR>"),
        dashboard.button(
          "f",
          "  Find file",
          "<cmd>lua require('telescope.builtin').find_files({no_ignore = true, hidden = true})<CR>"
        ),
        dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
      }
      require("alpha").setup(dashboard.config)
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        border = "none",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      local keymaps = {
        mode = { "n", "v" },
        ["<leader>d"] = { name = "+dap" },
        ["<leader>I"] = { name = "+iron" },
        ["<leader>l"] = { name = "+lsp" },
        ["<leader>sn"] = { name = "+noice" },
        ["<leader><tab>"] = { name = "+tab" },
      }
      wk.register(keymaps)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        globalstatus = true,
        section_separators = { left = " ", right = "" },
        component_separators = { left = " ", right = "" },
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
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
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
    event = "VeryLazy",
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
    event = "VeryLazy",
    config = true,
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "petertriho/nvim-scrollbar",
    },
    config = function()
      require("scrollbar.handlers.search").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      space_char_blankline = true,
      show_current_context = true,
      show_current_context_start = true,
    },
  },
}
