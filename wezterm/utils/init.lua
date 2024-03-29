local wezterm = require("wezterm")
local M = {}

function M.basename(s)
  return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

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

function M.merge_lists(t1, t2)
  local result = {}
  for _, v in pairs(t1) do
    table.insert(result, v)
  end
  for _, v in pairs(t2) do
    table.insert(result, v)
  end
  return result
end

function M.convert_home_dir(path)
  local cwd = path
  local home = os.getenv("HOME")
  cwd = cwd:gsub("^" .. home .. "/", "~/")
  if cwd == "" then
    return path
  end
  return cwd
end

function M.day_of_week_ja(w_num)
  if w_num == 1 then
    return "日"
  elseif w_num == 2 then
    return "月"
  elseif w_num == 3 then
    return "火"
  elseif w_num == 4 then
    return "水"
  elseif w_num == 5 then
    return "木"
  elseif w_num == 6 then
    return "金"
  elseif w_num == 7 then
    return "土"
  end
end

local function is_found(str, pattern)
  return string.find(str, pattern) ~= nil
end

function M.platform()
  local is_win = is_found(wezterm.target_triple, "windows")
  local is_linux = is_found(wezterm.target_triple, "linux")
  local is_mac = is_found(wezterm.target_triple, "apple")
  local os = is_win and "windows" or is_linux and "linux" or is_mac and "mac" or "unknown"

  return {
    os = os,
    is_win = is_win,
    is_linux = is_linux,
    is_mac = is_mac,
  }
end

return M
