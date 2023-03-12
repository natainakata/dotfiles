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

return M
