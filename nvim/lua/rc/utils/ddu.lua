local M = {}

local function safe_call(fn, ...)
  fn = type(fn) == "string" and vim.fn[fn] or fn
  if fn then
    fn(...)
  end
end

function M.action(name, params, stopinsert, callback)
  return function()
    if stopinsert then
      vim.cmd.stopinsert()
      vim.schedule(function()
        vim.fn["ddu#ui#do_action"](name, params or vim.empty_dict())
        safe_call(callback)
      end)
    else
      vim.fn["ddu#ui#do_action"](name, params or vim.empty_dict())
      safe_call(callback)
    end
  end
end

function M.item_action(name, params, stopinsert, callback)
  return M.action("itemAction", { name = name, params = params }, stopinsert, callback)
end

function M.execute(cmd)
  return function()
    vim.fn["ddu#ui#ff#execute"](cmd)
    vim.cmd.redraw()
  end
end

function M.ff_map(name, callback)
  name = name or "default"
  utils.autocmd("ddu-ff_map_" .. name, "FileType", "ddu-ff", function()
    -- Enable `file` map also for `file:foo`
    if name == "default" or string.find(vim.b.ddu_ui_name, name) then
      callback(function(lhs, rhs, opts)
        opts = vim.tbl_extend("keep", opts or {}, { nowait = true, buffer = true, silent = true })
        utils.nmap(lhs, rhs, opts)
      end)
    end
  end, {}, false)
end

function M.ff_filter_map(name, callback)
  name = name or "default"
  utils.autocmd("ddu-ff-filter_map_" .. name , "FileType", "ddu-ff-filter", function()
    -- Enable `file` map also for `file:foo`
    if name == "default" or string.find(vim.b.ddu_ui_name, name) then
      callback(function(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("keep", opts or {}, { nowait = true, buffer = true, silent = true })
        vim.keymap.set(mode, lhs, rhs, opts)
      end)
    end
  end, {}, false)
end

function M.patch_global(dict)
  vim.fn["ddu#custom#patch_global"](dict)
end

function M.patch_local(name, dict)
  vim.fn["ddu#custom#patch_local"](name, dict)
end

function M.alias(type, alias_name, base_name)
  vim.fn["ddu#custom#alias"](type, alias_name, base_name)
end

function M.start(name)
  return function()
    vim.fn["ddu#start"]({
      name = name
    })
  end
end

return M
