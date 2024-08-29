local icons = require("rc.utils.icons")
-- local utils = require("rc.utils")
local spec = {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    -- opts = function()
    --   -- local sonokai_conf = vim.fn["sonokai#get_configuration"]()
    --   -- local palette = vim.fn["sonokai#get_palette"](sonokai_conf.style, sonokai_conf.colors_override)
    --   -- local bg = palette.bg0[1]
    --   -- local bg = require("onedark.palette").dark.bg0
    --   -- local bg = require("catppuccin.palettes").get_palette("frappe").mantle,
    --   return { background_colour = bg }
    -- end,
    config = true,
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
    event = "VimEnter",
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
        command_palette = false,
        long_message_to_split = true,
      },
      cmdline = {
        view = "cmdline",
        ---@type table<string, CmdlineFormat>
        format = {
          input = {
            view = "cmdline",
          },
        },
      },

      ---@class NoiceConfigViews
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
      -- {
      --   "<C-Enter>",
      --   function()
      --     require("noice").redirect(vim.fn.getcmdline())
      --   end,
      --   mode = "c",
      --   desc = "Redirect Cmdline",
      -- },
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
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.buttons.val = {
        dashboard.button("n", icons.kinds.File .. " New File", "<Cmd>ene<CR>"),
        dashboard.button("e", icons.kinds.Folder .. " Browze Directory", "<Cmd>Oil<CR>"),
        dashboard.button("f", icons.other.search .. " Find File", "<Cmd>Telescope find_files<CR>"),
        dashboard.button("q", icons.other.exit .. " Quit NVIM", "<cmd>qa<CR>"),
      }
      require("alpha").setup(dashboard.config)
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      win = {
        border = "none",
      },
      plugins = {
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
        },
      },
    },

    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      local keymaps = {
        {
          mode = { "n", "v" },
          { "<C-g>", group = "git" },
          { "<leader><tab>", group = "tab" },
          { "<leader>I", group = "iron" },
          { "<leader>d", group = "dap" },
          { "<leader>l", group = "lsp" },
          { "<leader>n", group = "noice" },
          -- { "s", group = "window" },
        },
      }
      wk.add(keymaps)
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
      function _G.diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    dependencies = { "lewis6991/gitsigns.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        bt_ignore = { "terminal", "nofile" },
        relculright = true,
        segments = {
          {
            sign = {
              namespace = { "diagnostic" },
              auto = false,
              maxwidth = 1,
            },
          },
          {
            sign = {
              namespace = { "dap_breakpoints" },
              auto = true,
              maxwidth = 1,
            },
          },
          {
            sign = {
              namespace = { "gitsigns" },
              maxwidth = 1,
              colwidth = 1,
              auto = false,
              wrap = true,
            },
          },
          {
            text = { builtin.lnumfunc },
          },
          {
            text = { "|" },
          },
        },
      })
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

if is_nvim() then
  return spec
else
  return {}
end
