local utils = require("rc.utils")

utils.ensure("cmp", function(cmp)
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
end)
