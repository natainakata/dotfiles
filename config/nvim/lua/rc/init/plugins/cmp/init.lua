local icons = require("rc.utils.icons")
local spec = {
  {
    "hrsh7th/nvim-cmp",
    enabled = is_nvim(),
    event = { "InsertEnter", "CmdLineEnter" },
    version = false,
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
      {
        "hrsh7th/cmp-cmdline",
        dependencies = { "teramako/cmp-cmdline-prompt.nvim" },
      },
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local options = {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            col_offset = -3,
            side_padding = 0,
          },
          documentation = {},
        },
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            entry_filter = function(entry)
              if
                entry:get_kind() == require("cmp.types").lsp.CompletionItemKind.Snippet
                and entry.source:get_debug_name() == "nvim_lsp:emmet_ls"
              then
                return false
              end
              return true
            end,
          },
          {
            name = "buffer",
            keyword_length = 3,
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "treesitter" },
          { name = "path" },
          { name = "luasnip" },
          { name = "skkeleton" },
          { name = "emoji" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
              local entry = cmp.get_selected_entry()
              if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end
              cmp.confirm()
            else
              fallback()
            end
          end, { "i", "s", "c" }),
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
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local kind =
              lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = icons.kinds })(entry, item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
          end,
        },
      }
      cmp.setup(options)
      cmp.setup.filetype("lua", {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "treesiter" },
          {
            name = "buffer",
            keyword_length = 3,
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "path" },
          { name = "skkeleton" },
          { name = "emoji" },
        }),
      })
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
          { name = "skkeleton" },
        }),
      }
      cmp.setup.cmdline(":", cmdline_options)
      local gin_action = require("rc.init.plugins.cmp.sources.gin_action")
      cmp.register_source("gin_action", gin_action)
      cmp.setup.cmdline("@", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          {
            name = "cmdline-prompt",
            option = {
              excludes = { "customlist" },
              kinds = {
                buffer = cmp.lsp.CompletionItemKind.File,
                dir = cmp.lsp.CompletionItemKind.Folder,
                file = cmp.lsp.CompletionItemKind.File,
                packadd = cmp.lsp.CompletionItemKind.Module,
                runtime = cmp.lsp.CompletionItemKind.Folder,
                scriptnames = cmp.lsp.CompletionItemKind.File,
              },
            },
          },
          { name = "gin_action" },
        }),
        formatting = {
          expandable_indicator = true,
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local item = entry:get_completion_item()
            if entry.source.name == "cmdline-prompt" then
              local kind =
                lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50, symbol_map = icons.kinds })(entry, vim_item)
              local strings = vim.split(kind.kind, "%s", { trimempty = true })
              kind.kind = " " .. (strings[1] or "") .. " "
              kind.menu = "    (" .. (strings[2] or "") .. ")"

              return kind
            elseif entry.source.name == "gin_action" then
              vim_item.kind = gin_action.get_symbol(item.label:match("^%w+"))
              return vim_item
            else
              return vim_item
            end
          end,
        },
        window = {
          completion = {
            col_offset = 6,
          },
        },
      })

      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
      end)
      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)
    end,
  },
}

return spec
