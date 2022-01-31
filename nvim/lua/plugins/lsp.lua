local util = require('utils')
local nvim_lsp = require('lspconfig')
local lsp_installer = require("nvim-lsp-installer")

local on_attach = function(client, bufnr)
  local opts = { silent=true }
  util.bufmap(bufnr, "n", "<Leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  util.bufmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  util.bufmap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>ltd", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  util.bufmap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>le", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>dk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>dj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  util.bufmap(bufnr, "n", "<Leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local deno_root_dir = nvim_lsp.util.root_pattern("package.json")
local is_deno_repo = deno_root_dir(vim.api.nvim_buf_get_name(0), vim.api.nvim_get_current_buf()) ~= nil

lsp_installer.on_server_ready(function(server)
  local opts = {}
  opts.on_attach = on_attach

  if server.name == "tsserver" or server.name == "eslint" then
    opts.autostart = is_deno_repo
  elseif server.name == "denols" then
    opts.autostart = not(is_deno_repo)
    opts.init_options = { lint = true, unstable = true }
  end

  if server.name == "sumneko_lua" then
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    opts.settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnositcs = {
          globals = {'vim'},
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        }
      }
    }
  end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
  opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
end)

util.opt.completeopt = 'menu,menuone,noselect'
