local utils = require("rc.utils")
local spec = {

  
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      {
        "rinx/cmp-skkeleton",
        enabled = true,
        dependencies = { "vim-skk/skkeleton" },
      },
      "PaterJason/cmp-conjure",
      "hrsh7th/cmp-emoji",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    
    config = function()
      local cmp = require("cmp")
      cmp.setup({
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
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
          { name = "emoji" },
          { name = "skkeleton" },
          { name = "conjure" },
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
          format = function(_, item)
            local icons = require("rc.utils.icons").kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "nvim_lsp_document_symbol" },
        }),
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline", keyword_length = 2 },
        }),
      })
    end,
  },
  {
    "vim-skk/skkeleton",
    enabled = true,
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      { "delphinus/skkeleton_indicator.nvim", config = true },
      "kei-s16/skkeleton-azik-kanatable"
    },
    config = function()
      utils.imap("<C-j>", "<Plug>(skkeleton-toggle)")
      utils.cmap("<C-j>", "<Plug>(skkeleton-toggle)")

      vim.fn["denops#plugin#wait_async"]("skkeleton", function()
        vim.fn["skkeleton#register_keymap"]("input", ";", "henkanPoint")
        vim.fn['skkeleton#azik#add_table']('us')
        local dictionaries = {
          "~/.skk/SKK-JISYO.L",
        }
        vim.fn["skkeleton#config"]({
          eggLikeNewline = true,
          registerConvertResult = true,
          kanaTable = "azik",
          globalDictionaries = dictionaries,
          userJisyo = "~/.skk/SKK-JISYO.user",
        })
        vim.fn["skkeleton#initialize"]()
      end)
    end,
  },
  {
    "L3MON4D3/LuaSnip",
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
        expr = true, silent = true, mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,   mode = "s" },
      { "<s-tab>", function() require("luasnip").jump( -1) end, mode = { "i", "s" } },
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
    "DaeZak/crafttweaker-vim-highlighting",
    ft = "crafttweaker",
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
  {
    "wlangstroth/vim-racket",
    ft = "racket",
  },
  {
    "Olical/conjure",
    dependencies = {
      "clojure-vim/vim-jack-in",
      dependencies = {
        "tpope/vim-dispatch",
        "radenling/vim-dispatch-neovim",
      },
    },
    ft = { "clojure", "scheme", "racket", "lisp" },
    config = function()
      vim.g["conjure#client#scheme#stdio#command"] = "gosh -i"
      vim.g["conjure#client#scheme#stdio#prompt_pattern"] = "gosh[>$] "
      vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false
      vim.g["conjure#mapping#prefix"] = "<Leader>C"
      vim.g["conjure#mapping#eval_root_form"] = "r"
      vim.g["conjure#mapping#eval_comment_root_form"] = "cr"
      vim.g["conjure#mapping#eval_current_form"] = "x"
      vim.g["conjure#mapping#eval_comment_current_form"] = "cx"
      vim.g["conjure#mapping#eval_word"] = "w"
      vim.g["conjure#mapping#eval_comment_word"] = "cw"
      vim.g["conjure#mapping#eval_visual"] = "v"
      vim.g["conjure#mapping#eval_file"] = "f"
      vim.g["conjure#mapping#eval_buf"] = "b"
    end,
  },
  {
    "guns/vim-sexp",
    dependencies = {
      "tpope/vim-sexp-mappings-for-regular-people",
      "tpope/vim-repeat",
    },
    ft = { "clojure", "scheme", "lisp" },
    config = function()
      vim.g.sexp_enable_insert_mode_mappings = 1
    end,
  },
}

return spec
