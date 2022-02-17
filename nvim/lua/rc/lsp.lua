local util = require('utils')
local lspconfig = require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(client, bufnr)
  local opts = { silent=true }
  util.bufmap(bufnr, "n", "<Leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>ld", "<cmd>lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_cursor({}))<CR>", opts)
  util.bufmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>li", "<cmd>lua require('telescope.builtin').lsp_implementation(require('telescope.themes').get_cursor({}))<CR>", opts)
  util.bufmap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  util.bufmap(bufnr, "n", " Leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lws", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lwd", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>ltd", "<cmd>lua require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_cursor({}))<CR>", opts)
  util.bufmap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>la", "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lr", "<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy({}))<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>le", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>dk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>dj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local deno_root_dir = lspconfig.util.root_pattern("package.json")
local is_deno_repo = deno_root_dir(vim.api.nvim_buf_get_name(0), vim.api.nvim_get_current_buf()) ~= nil
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_installer.on_server_ready(function(server)
  local opts = {}
  opts.on_attach = on_attach
  opts.capabilities = capabilities

  if server.name == "tsserver" or server.name == "eslint" then
    opts.autostart = is_deno_repo
  elseif server.name == "denols" then
    opts.autostart = not(is_deno_repo)
    opts.init_options = { lint = true, unstable = true }
  end

  if server.name == "sumneko_lua" then
    local runtime_path = vim.split(package.path, ';')
    --table.insert(runtime_path, "lua/?.lua")
    --table.insert(runtime_path, "lua/?/init.lua")
    opts.settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path
        },
        diagnositcs = {
          enable = true,
          globals = {'vim', 'use', 'it', 'before_each', 'after_each'},
        },
        workspace = {
          library = {
          }
        }
      }
    }
  end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

util.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}
