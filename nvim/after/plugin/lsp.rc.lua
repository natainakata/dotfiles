local status, mason = pcall(require, 'mason')
if (not status) then return end

mason.setup()
local nvim_lsp = require 'lspconfig'
-- LSP handlers

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
-- )

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { textthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

require 'mason-lspconfig'.setup_handlers({ function(server)

  local opts = {}

  if server == "tsserver" or server == "eslint" then
    opts.root_dir = nvim_lsp.util.root_pattern("package.json")
  else if server == "denols" then
    opts.root_dir = nvim_lsp.util.root_pattern("deno.json")
    opts.init_options = {
      lint = true,
      unstable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
            ["https://cdn.nest.land"] = true,
            ["https://crux.land"] = true
          }
        }
      }
    }
  end

  if server == "sumneko_lua" then
    opts.settings = {
      Lua = {
        diagnostics = { globals = { 'vim' } },
      }
    }
  end

  end
    opts.on_attach = function(client, bufnr) 
    local opt = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ld', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>le', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  end
  opts.capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
  )
  nvim_lsp[server].setup(opts)
end })

-- Reference highlight
-- vim.cmd [[
-- set updatetime=500
-- highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- augroup lsp_document_highlight
--   autocmd!
--   autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
--   autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
-- augroup END
-- ]]
