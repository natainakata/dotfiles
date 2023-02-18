return {
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "luasnip" },
          { name = "emoji" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-l>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        experimental = {
          ghost_text = true,
        },
        formatting = {
          format = function(_, item)
            local icons = require('natai.icons').icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] ..  item.kind
            end
            return item
          end,
        },
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
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
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
  {
    "hrsh7th/cmp-cmdline",
    lazy = true,
    config = function()
      local cmp = require("cmp")
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      })
    end,
  },

  {
    "monaqa/dial.nvim",
    lazy = true,
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
    "machakann/vim-sandwich",
    lazy = true,
    keys = {
      { "sa", "<Plug>(sandwich-add)" },
      { "sd", "<Plug>(sandwich-delete)" },
      { "sdb", "<Plug>(sandwich-delete-auto)" },
      { "sr", "<Plug>(sandwich-replace)" },
      { "srb", "<Plug>(sandwich-replace-auto)" },
    },
  },
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = "InsertEnter",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    lazy = true,
    event = "BufEnter",
    config = true,
  },
  {
    "DaeZak/crafttweaker-vim-highlighting",
    lazy = true,
    ft = "crafttweaker",
  },
}
