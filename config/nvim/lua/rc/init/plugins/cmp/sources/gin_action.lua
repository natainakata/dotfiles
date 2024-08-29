-- from: https://github.com/teramako/dotfiles/blob/main/nvim/lua/cmp-gin-action/init.lua
local source = {}

source.kinds = {
  _ = { symbol = "󰊢 " },
  rm = { symbol = " " },
  add = { symbol = " " },
  browse = { symbol = " " },
  chaperon = { symbol = "󰹬 " },
  choice = { symbol = "󰴅 " },
  delete = { symbol = "󰧧 " },
  diff = { symbol = " " },
  echo = { symbol = "󰍥 " },
  edit = { symbol = "󱇨 " },
  help = { symbol = "󰮦 " },
  log = { symbol = " " },
  move = { symbol = "󱉆 " },
  new = { symbol = " " },
  patch = { symbol = "󰶯 " },
  ["repeat"] = { symbol = "󰕇 " },
  reset = { symbol = " " },
  restore = { symbol = "󰙰 " },
  stage = { symbol = "󰁝 " },
  stash = { symbol = " " },
  unstage = { symbol = "󰁅 " },
  yank = { symbol = "󰅌 " },
  ["cherry-pick"] = { symbol = " " },
  fixup = { symbol = "󰁨 " },
  merge = { symbol = "" },
  rebase = { symbol = "󱌣 " },
  revert = { symbol = "󱞯" },
  show = { symbol = "󰛐" },
  switch = { symbol = "󰘬 " },
  tag = { symbol = "󰓼 " },
}

source.get_symbol = function(action_name)
  return source.kinds[action_name].symbol
end

source.is_available = function()
  local ft = vim.bo.filetype
  if string.match(ft, "^gin%-") then
    return true
  end
  return false
end

---@param callback fun(response: lsp.CompletionList|lsp.CompletionItem[]|nil)
source.complete = function(_, _, callback)
  local items = {}
  for _, nmap in ipairs(vim.api.nvim_buf_get_keymap(0, "n")) do
    local action = string.match(nmap.lhs, "<Plug>%(gin%-action%-(%S+)%)")
    if action then
      table.insert(items, {
        label = action,
        kind = 1,
        sortText = action,
        data = { names = vim.split(action, ":") },
      })
    end
    callback(items)
  end
end

return source
