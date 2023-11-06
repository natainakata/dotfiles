local icons = require("rc.utils.icons")
local utils = require("rc.utils")
local spec = {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = function()
      -- local sonokai_conf = vim.fn["sonokai#get_configuration"]()
      -- local palette = vim.fn["sonokai#get_palette"](sonokai_conf.style, sonokai_conf.colors_override)
      -- local bg = palette.bg0[1]
      -- local bg = require("catppuccin.palettes").get_palette("frappe").mantle,
      local bg = require("onedark.palette").dark.bg0
      return { background_colour = bg }
    end,
    keys = {
      {
        "<leader>nu",
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
    dependencies = {
      "rcarriga/nvim-notify",
      "MunifTanjim/nui.nvim",
    },
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
      cmdline = {
        view = "cmdline",
      },
      views = {
        mini = {
          win_options = {
            winblend = 10,
            winhighlight = {
              Normal = "StatusLine",
            },
          },
        },
      },
    },
    keys = {
      {
        "<C-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>nl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>nh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>na",
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
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.buttons.val = {
        dashboard.button("n", icons.kinds.File .. " New File", "<Cmd>ene<CR>"),
        dashboard.button("e", icons.kinds.Folder .. " Browze Directory", "<Cmd>NvimTreeOpen<CR>"),
        dashboard.button("f", icons.other.search .. " Find File", "<Cmd>Telescope find_files<CR>"),
        dashboard.button("q", icons.other.exit .. " Quit NVIM", "<cmd>qa<CR>"),
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
        ["<leader>n"] = { name = "+noice" },
        ["<C-g>"] = { name = "+git" },
        ["s"] = { name = "+substitute" },
        ["<leader><tab>"] = { name = "+tab" },
      }
      wk.register(keymaps)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          {
            "filename",
            newfile_status = true,
            path = 1,
            shorting_target = 24,
            symbols = { modified = icons.files.modified, readonly = icons.files.readonly },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic", "nvim_lsp" },
            sections = { "error", "warn", "info", "hint" },
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },

        lualine_x = {
          "encoding",
        },
        lualine_y = {
          -- { "filetype", color = { fg = require("onedark.palette").dark.fg } },
        },
        lualine_z = {
          { "fileformat", icons_enabled = true, separator = { left = "", right = "" } },
        },
      },
      tabline = {
        lualine_a = {
          {
            "buffers",
            symbols = {
              modified = " " .. icons.files.modified,
              directory = " " .. icons.kinds.Folder,
            },
          },
        },
        lualine_b = {},
        lualine_c = {
          {
            "navic",
            color_correction = "static",
            navic_opts = {
              depth_limit = 9,
            },
          },
        },
        lualine_x = {
          {
            "diff",
            symbols = {
              added = icons.git.added .. " ",
              modified = icons.files.modified .. " ",
              removed = icons.git.removed .. " ",
            },
            source = utils.diff_source,
          },
        },
        lualine_y = {
          { "b:gitsigns_head", icon = { icons.git.branch } },
        },
        lualine_z = {
          "tabs",
        },
      },
      extensions = {
        "man",
        "lazy",
        "nvim-tree",
        "quickfix",
        "symbols-outline",
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
      require("gitsigns").setup({})
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
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },
}

return spec
