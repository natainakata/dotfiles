import type { Plug } from "https://deno.land/x/dvpm@1.0.0/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/execute.ts";
import { notify } from "../util.ts";

export const lsp: Plug[] = [
  {
    url: "neovim/nvim-lspconfig",
    dependencies: [
      { url: "williamboman/mason.nvim" },
      { url: "williamboman/mason-lspconfig.nvim" },
      { url: "folke/trouble.nvim" },
      // { url: "lukas-reineke/lsp-format.nvim" },
      { url: "jose-elias-alvarez/null-ls.nvim" },
      {
        url: "simrat39/symbols-outline.nvim",
        after: async ({ denops }) => {
          await denops.cmd(`lua require("symbols-outline").setup()`);
        },
      },
      {
        url: "SmiteshP/nvim-navic",
        after: async ({ denops }) => {
          await denops.call(
            `luaeval`,
            `require("nvim-navic").setup(_A.param)`,
            {
              param: { lsp: { auto_attach: true }, highlight: true },
            },
          );
        },
      },
      {
        url: "folke/neodev.nvim",
        dependencies: [{ url: "neovim/nvim-lspconfig" }],
        after: async ({ denops }) => {
          await denops.call(
            `luaeval`,
            `require("neodev").setup(_A.param)`,
            {
              param: { experimental: { pathStrict: true } },
            },
          );
        },
      },
      {
        url: "folke/neoconf.nvim",
        dependencies: [{ url: "neovim/nvim-lspconfig" }],
        after: async ({ denops }) => {
          await denops.cmd(`lua require("neoconf").setup()`);
        },
      },
    ],

    after: async ({ denops }) => {
      await execute(
        denops,
        `
lua << EOB
require("mason").setup({
            providers = {
              "mason.providers.client",
              "mason.providers.registry-api",
            },
})
ensure_installed = {
            "stylua",
            "shellcheck",
            "shfmt",
            "flake8",
            "prettier",
            "lua-language-server",
            "vim-language-server",
            "deno",
          }
require("mason-lspconfig").setup()
for _, tool in ipairs(ensure_installed) do
  p = require("mason-registry").get_package(tool)
  if not p:is_installed() then
    p:install()
  end
end


function on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      bufnr = args.buf
      client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, bufnr)
    end,
  })
end

on_attach(function(client, bufnr)
  opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "g[", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "g]", function() vim.diagnostic.gotio_next() end, opts)
  vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "gK", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "gR", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<Leader>F", function() vim.lsp.buf.format() end, opts)
end)

lspconfig = require("lspconfig")
capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits"
  }
}
options = {
  capabilities = capabilities,
}

require("mason-lspconfig").setup_handlers({
function(server_name)
  lspconfig[server_name].setup(options)
end,

lua_ls = function() 
  lspconfig["lua_ls"].setup(vim.tbl_deep_extend("force", options, {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  }))
end,

denols = function()
  lspconfig["denols"].setup(vim.tbl_deep_extend("force", options, {
    root_dir = lspconfig.util.root_pattern("deno.json"),
    init_options = {
      lint = true,
      unstable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
            ["https://cdn.nest.land"] = true,
            ["https://crux.land"] = true,
          },
        },
      },
    },
  }))
end,
kotlin_language_server = function()
  lspconfig["kotlin_language_server"].setup(vim.tbl_deep_extend("force", options, {
    -- root_dir = lspconfig.util.root_pattern("build.gradle.kts"),
  }))
end,

powershell_es = function()
  lspconfig["powershell_es"].setup(vim.tbl_deep_extend("force", options, {
  mason = false,
  settings = {
    powershell = {
      codeFormatting = {
        preset = "OTBS",
        newLineAfterOpenBrace = false,
        newLineAfterCloseBrace = true,
      },
    },
  },
  on_attach = on_attach(function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end),
}))
end,
})`,
      );
      await notify(denops, "lsp loaded");
    },
  },
];
