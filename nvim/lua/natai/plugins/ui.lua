local icons = require("natai.icons")
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end
local spec = {
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "NormalFloat",
    },
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
    lazy = false,
    dependencies = "rcarriga/nvim-notify",
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
    lazy = true,
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
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", "<cmd>ene<CR>"),
        dashboard.button("e", "  Browze Directory", "<cmd>NvimTreeOpen<CR>"),
        dashboard.button(
          "f",
          "  Find file",
          "<cmd>lua require('telescope.builtin').find_files({no_ignore = true, hidden = false})<CR>"
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
        ["<leader>n"] = { name = "+noice" },
        ["<C-g>"] = { name = "+git" },
        ["<leader><tab>"] = { name = "+tab" },
      }
      wk.register(keymaps)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
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
          { "filetype", color = { fg = require("onedark.palette").dark.fg } },
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
            source = diff_source,
          },
        },
        lualine_y = {
          { "b:gitsigns_head", icon = { icons.git.branch } },
        },
        lualine_z = {
          "tabs",
        },
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
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
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

if vim.g.vscode then
  return {}
else
  return spec
end
