local M = {}

---Merge extended options with a default table of options
---@param default table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

---Get lazy plugins opts table
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

---plugin ensure call
---@param spec string plugin spec
---@param callback fun(...) callback function
---@return boolean|nil ok #pcall status
---@return Object|nil module #plugin module
---@return fun(...)|nil callback arg callback function
---source: https://github.com/kyoh86/dotfiles/blob/8c834eb1de6e8f1cd2e021c506cba7de42eb971a/nvim/lua/kyoh86/root/preload.lua
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
---@param rhs string|fun(...) mapped expr
---@param opts? table
function M.nmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("n", lhs, rhs, opts)
end

--- Insert mode define keymap
---@param lhs string key binds
---@param rhs string|fun(...) mapped expr
---@param opts? table
function M.imap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("i", lhs, rhs, opts)
end

--- Visual mode define keymap
---@param lhs string key binds
---@param rhs string|fun(...) mapped expr
---@param opts? table
function M.xmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("v", lhs, rhs, opts)
end

--- cmdline mode define keymap
---@param lhs string key binds
---@param rhs string|fun(...) mapped expr
---@param opts? table
function M.cmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("c", lhs, rhs, opts)
end

--- Terminal mode define keymap
---@param lhs string key binds
---@param rhs string|fun(...) mapped expr
---@param opts? table
function M.tmap(lhs, rhs, opts)
  opts = opts or default_key_opts
  vim.keymap.set("t", lhs, rhs, opts)
end

---@param opfunc string use operator function
---@return fun(motion:string) #feedkey function
function M.operator(opfunc)
  vim.o.operatorfunc = opfunc
  return function(motion)
    vim.api.nvim_feedkeys("g@" .. (motion or ""), "mi", false)
  end
end

---define augroup
---@param name string
---@return number augroup #augroup id
function M.augroup(name)
  return vim.api.nvim_create_augroup("natai_" .. name, { clear = true })
end

---define autocmd
---@param name string autocmd name
---@param event string|string[] trigger event
---@param pattern string|string[]|nil trigger pattern
---@param callback string|fun(...) callback command or function
---@param opts? table autocmd option
---@param clear? boolean augroup clear option
function M.autocmd(name, event, pattern, callback, opts, clear)
  opts = opts or {}
  if clear == nil then
    clear = true
  end
  if type(callback) == "string" then
    opts = M.extend_tbl(opts, {
      group = vim.api.nvim_create_augroup("natai_" .. name, { clear = clear }),
      pattern = pattern,
      command = callback,
    })
  elseif type(callback) == "function" then
    opts = M.extend_tbl(opts, {
      group = vim.api.nvim_create_augroup("natai_" .. name, { clear = clear }),
      pattern = pattern,
      callback = callback,
    })
  end
  vim.api.nvim_create_autocmd(event, opts)
end

return M
