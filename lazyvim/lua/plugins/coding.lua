return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "hrsh7th/cmp-cmdline",
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
      { "hrsh7th/cmp-emoji" },
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local maps = {
        ["<C-l>"] = cmp.mapping.complete({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
      opts.mapping = cmp.mapping.preset.insert(vim.list_extend(opts.mapping, maps))
    end,
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
      },
    },
  },
}
