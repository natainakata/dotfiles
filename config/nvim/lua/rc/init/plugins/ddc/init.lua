local utils = require("rc.utils")

local spec = {
  {
    "Shougo/ddc.vim",
    enabled = false,
    dependencies = {
      "vim-denops/denops.vim",
      {
        "Shougo/pum.vim",
        opts = {
          auto_confirm_time = 0,
          auto_select = false,
          commit_characters = { "." },
          max_width = 80,
          offset_cmdcol = 0,
          padding = false,
          preview = true,
          preview_width = 80,
          reversed = false,
          use_setline = false,
        },
        config = function(_, opts)
          vim.fn["pum#set_option"](opts)
        end,
      },
      "Shougo/ddc-ui-pum",
      -- source
      "LumaKernel/ddc-source-file",
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-cmdline",
      "Shougo/ddc-source-cmdline-history",
      "Shougo/ddc-source-input",
      "Shougo/ddc-source-nvim-lsp",
      "Shougo/ddc-source-rg",
      "Shougo/ddc-source-shell",
      "Shougo/ddc-source-shell-native",
      "matsui54/ddc-buffer",
      "uga-rosa/ddc-source-nvim-lua",
      -- filter
      "Shougo/ddc-filter-converter_remove_overlap",
      "Shougo/ddc-filter-matcher_head",
      "Shougo/ddc-filter-matcher_length",
      "Shougo/ddc-filter-matcher_prefix",
      "Shougo/ddc-filter-sorter_head",
      "Shougo/ddc-filter-sorter_rank",
    },
    event = "InsertEnter",
  },
}

return spec
