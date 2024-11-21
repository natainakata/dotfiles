local utils = require("rc.utils")
local spec = {
  {
    "vim-skk/skkeleton",
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      -- "kei-s16/skkeleton-azik-kanatable",
      { "skk-dev/dict", name = "skk-dict" },
    },
    config = function()
      utils.imap("<C-u>", "<Plug>(skkeleton-toggle)")
      utils.cmap("<C-u>", "<Plug>(skkeleton-toggle)")
      utils.tmap("<C-u>", "<Plug>(skkeleton-toggle)")
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
}

return spec
