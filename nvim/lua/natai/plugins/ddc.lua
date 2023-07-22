return {
  {
    "Shougo/ddc.vim",
    lazy = false,
    dependencies = {
      "vim-denops/denops.vim",
      -- UI
      "Shougo/ddc-ui-native",
      -- Source
      "tani/ddc-fuzzy",
      -- Preview
    },
    config = function()
      local patch_global = vim.fn["ddc#custom#patch_global"]

      patch_global("ui", "native")

      patch_global("sources", {
        "skkeleton",
      })

      patch_global("sourceOptions", {
        skkeleton = {
          mark = "[SKK]",
          matchers = { "skkeleton" },
          sorters = {},
          converters = {},
          isVolatile = true,
          minAutoCompleteLength = 2,
        },
      })
      vim.fn["ddc#enable"]()
    end,
  },
}
