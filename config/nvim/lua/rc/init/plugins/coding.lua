local utils = require("rc.utils")
local spec = {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", neocodeium.accept)
    end,
  },
  {
    "vim-skk/skkeleton",
    lazy = false,
    enabled = is_nvim(),
    dependencies = {
      "vim-denops/denops.vim",
      -- "kei-s16/skkeleton-azik-kanatable",
      { "skk-dev/dict", name = "skk-dict" },
    },
    config = function()
      if is_nvim() then
        utils.imap("<C-u>", "<Plug>(skkeleton-toggle)")
        utils.cmap("<C-u>", "<Plug>(skkeleton-toggle)")
        utils.tmap("<C-u>", "<Plug>(skkeleton-toggle)")
      else
        utils.imap("<C-j>", "<Plug>(skkeleton-toggle)")
      end

      -- vim.fn["skkeleton#azik#add_table"]("us")
      local dictionaries = {
        vim.fn.stdpath("data") .. "/lazy/skk-dict/SKK-JISYO.L",
      }
      vim.fn["skkeleton#config"]({
        eggLikeNewline = true,
        registerConvertResult = true,
        -- kanaTable = "azik",
        globalDictionaries = dictionaries,
        userDictionary = "~/.skk/SKK-JISYO.user",
      })
      vim.fn["skkeleton#register_kanatable"]("rom", {
        jk = "escape",
      })
      -- vim.fn["skkeleton#register_kanatable"]("azik", {
      --   kf = { "き", "" },
      --   jf = { "じゅ", "" },
      --   hf = { "ふ", "" },
      --   yf = { "ゆ", "" },
      --   mf = { "む", "" },
      --   nf = { "ぬ", "" },
      --   df = { "で", "" },
      --   cf = { "ちぇ", "" },
      --   pf = { "ぽん", "" },
      -- })
      vim.fn["skkeleton#initialize"]()
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    enabled = is_nvim(),
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    event = "InsertEnter",
    cmd = "Copilot",
    keys = {
      {
        "<M-j>",
        function()
          require("copilot.suggestion").toggle_auto_trigger()
        end,
        silent = true,
        mode = "i",
      },
    },
    opts = {
      filetypes = {
        markdown = true,
        gitcommit = true,
        yaml = true,
      },
    },
  },
  {
    "monaqa/dial.nvim",
    keys = {
      { "+", "<Plug>(dial-increment)", desc = "Increment" },
      { "-", "<Plug>(dial-decrement)", desc = "Decrement" },
    },
    config = function()
      local dial = require("dial.config")
      local augend = require("dial.augend")
      dial.augends:register_group({
        -- augends used when group with name `mygroup` is specified
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.date.alias["%Y/%m/%d"],
        },
      })
    end,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },
  {
    "cohama/lexima.vim",
    event = "InsertEnter",
    config = function()
      vim.fn["lexima#add_rule"]({
        filetype = {
          "scheme",
          "clojure",
          "lisp",
        },
        char = "'",
        input = "'",
      })
      vim.fn["lexima#add_rule"]({
        filetype = {
          "scheme",
          "clojure",
          "lisp",
        },
        char = "`",
        input = "`",
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "gbprod/substitute.nvim",
    keys = {
      {
        "m",
        function()
          require("substitute").operator()
        end,
      },
      {
        "mm",
        function()
          require("substitute").line()
        end,
        desc = "Lines",
      },
      {
        "M",
        function()
          require("substitute").eol()
        end,
        desc = "Substitute File",
      },

      {
        "m",
        function()
          require("substitute").visual()
        end,
        mode = "x",
        desc = "Substitute Visual",
      },
    },
    config = true,
  },
  {
    "DaeZak/crafttweaker-vim-highlighting",
    enabled = is_nvim(),
    ft = "crafttweaker",
  },
  {
    "Grazfather/sexp.nvim",
    dependencies = {
      "tpope/vim-repeat",
    },
    ft = { "lisp", "clojure", "scheme", "fennel" },
    opts = {
      mappings = {
        sexp_move_to_prev_element_head = "B",
        sexp_move_to_next_element_head = "W",
        sexp_move_to_prev_element_tail = "gE",
        sexp_move_to_next_element_tail = "E",
        sexp_insert_at_list_head = "<I",
        sexp_insert_at_list_tail = ">I",
        sexp_swap_list_backward = "<f",
        sexp_swap_list_forward = ">f",
        sexp_swap_element_backward = "<e",
        sexp_swap_element_forward = ">e",
        sexp_emit_head_element = ">(",
        sexp_emit_tail_element = "<)",
        sexp_capture_prev_element = "<(",
        sexp_capture_next_element = ">)",
      },
    },
  },
  {
    "Shougo/context_filetype.vim",
    event = { "BufReadPre", "BufNewFile" },
  },
}

return spec
