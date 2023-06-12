local M = {}

function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- source: https://github.com/ryoppippi/dotfiles/blob/3b19caa12b6911a738da4f39604f525176f35f48/nvim/lua/core/utils.lua
function M.merge_tables(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == "table") and (type(t1[k] or false) == "table") then
      M.merge_tables(t1[k], t2[k])
    else
      t1[k] = v
    end
  end
  return t1
end

-- source: https://github.com/kyoh86/dotfiles/blob/8c834eb1de6e8f1cd2e021c506cba7de42eb971a/nvim/lua/kyoh86/root/preload.lua
function M.ensure(spec, callback)
  local ok, module = pcall(require, spec)
  if ok then
    if callback then
      return callback(module)
    end
  else
    vim.notify(string.format("failed to load module %q", spec), vim.log.levels.WARN)
  end
  return ok, module
end

M.is_nvim = function()
  if vim.g.vscode then
    return false
  else
    return true
  end
end

return M
