return {
  filetypes = { "fennel" },
  root_dir = require("lspconfig.util").root_pattern("fnl"),
  single_file_support = true,
  settings = {
    fennel = {
      diagnostics = {
        globals = { "vim", "jit", "comment"},
      },
      workspace = {
        library = vim.api.nvim_list_runtime_paths(),
      },
    },
  },
}
