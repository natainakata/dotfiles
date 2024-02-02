---wrapper boolean flag
---source https://github.com/ryoppippi/dotfiles/blob/fba410346e51e128a590d17d22bb1d439110c5c3/nvim/lua/config/global.lua#L1
---@param value any check value
---@return boolean
function _G.tb(value)
  if value == nil then
    return false
  elseif type(value) == "boolean" then
    return value
  elseif type(value) == "number" then
    return value ~= 0
  elseif type(value) == "string" then
    return string.lower(value) == "true"
  else
    return false
  end
end

function _G.is_nvim()
  return not tb(vim.g.vscode)
end

