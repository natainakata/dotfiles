local M = {}

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Get lazy plugins opts table
---@param name string Plugin name
---@return table # Opts table
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
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

local default_key_opts = { silent = true, noremap = true }

--- Normal mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.nmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("n", lhs, rhs, opts)
end

--- Insert mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.imap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("i", lhs, rhs, opts)
end

--- Visual mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.xmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("v", lhs, rhs, opts)
end

--- cmdline mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.cmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("c", lhs, rhs, opts)
end

--- Terminal mode define keymap
---@param lhs string key binds
---@param rhs string|function mapped expr
function M.tmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("t", lhs, rhs, opts)
end

function M.augroup(name)
  return vim.api.nvim_create_augroup("natai_" .. name, { clear = true })
end

function M.diff_source()
  M.ensure("gitsigns", function(m)
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end)
end

M.is_nvim = function()
  if vim.g.vscode then
    return false
  else
    return true
  end
end

M.lsp = require("natai.utils.lsp")

return M
