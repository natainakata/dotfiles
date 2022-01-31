local cmp = require"cmp"
local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "ultisnips" },
  }, {
    { name = "buffer" },
    { name = "path" },
  },{
  })
})


