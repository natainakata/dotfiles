local utils = require("rc.utils")
local spec = {
  {
    "hrsh7th/nvim-cmp",
    enabled = is_nvim(),
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      {
        "uga-rosa/cmp-skkeleton",
        dependencies = { "vim-skk/skkeleton" },
      },
      "hrsh7th/cmp-emoji",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local options = {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "single",
          }),
          documentation = cmp.config.window.bordered({
            border = "single",
          }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          {
            name = "buffer",
            keyword_length = 3,
            max_item_count = 3,

            -- ここから
            -- 開いているすべてのバッファーを対象とする
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "treesitter" },
          { name = "path" },
          { name = "luasnip" },
          { name = "emoji" },
          { name = "skkeleton" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        experimental = {
          ghost_text = true,
        },
        formatting = {
          format = function(entry, item)
            local icons = require("rc.utils.icons").kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[Lua]",
              luasnip = "[Snip]",
              path = "[Path]",
              treesitter = "[Treesitter]",
              emoji = "[🤔]",
              skkeleton = "[SKK]",
              cmdline = "[CMD]",
            })[entry.source.name]
            return item
          end,
        },
      }
      cmp.setup(options)
      local search_options = {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "nvim_lsp_document_symbol" },
        }),
      }
      cmp.setup.cmdline({ "/", "?" }, search_options)
      local cmdline_options = {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline", keyword_length = 2 },
        }),
      }
      cmp.setup.cmdline(":", cmdline_options)
      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
      end)
      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)
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
      utils.imap("<C-j>", "<Plug>(skkeleton-toggle)")
      utils.cmap("<C-j>", "<Plug>(skkeleton-toggle)")

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
    enabled = is_nvim(),
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
    event = { "BufReadPre", "BufNewFile" },
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
        "s",
        function()
          require("substitute").operator()
        end,
      },
      {
        "ss",
        function()
          require("substitute").line()
        end,
        desc = "Lines",
      },
      {
        "S",
        function()
          require("substitute").eol()
        end,
        desc = "Substitute File",
      },

      {
        "s",
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
    "iamcco/markdown-preview.nvim",
    enabled = is_nvim(),
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
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
}

return spec
