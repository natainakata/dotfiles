local M = {}
M.settings = {
  Lua = {
    diagnositcs = {
      globals = { "vim" },
    },
    runtime = {
      version = "LuaJIT",
      path = vim.split(package.path, ":"),
    },
    workspace = {
      library = vim.api.nvim_get_runtime_file("", true),
    }
  }
}

return M
