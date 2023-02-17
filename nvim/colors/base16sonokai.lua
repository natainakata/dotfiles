local palette
palette = {
  base00 = "#2d2a2e", -- light background
  base01 = "#37343a", -- background
  base02 = "#423f46", -- selection
  base03 = "#848089", -- comment
  base04 = "#66d9ef", -- foreground
  base05 = "#e3e1e4", -- dark foreground
  base06 = "#a1efe4", -- light foreground
  base07 = "#f8f8f2", -- light background
  base08 = "#f85e84", -- variables
  base09 = "#ef9062", -- integer
  base0A = "#a6e22e", -- classes
  base0B = "#e5c463", -- string
  base0C = "#66d9ef", -- escape
  base0D = "#9ecd6f", -- function
  base0E = "#a1efe4", -- keyword
  base0F = "#f9f8f5", -- tags
}

if palette then
  local status, base16 = pcall(require, "mini.base16")
  if not status then
    return
  end
  base16.setup({
    palette = palette,
    use_cterm = false,
    plugins = { default = true },
  })
  if not vim.g.neovide then
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { bg = palette.base01, fg = palette.base03 })
    vim.api.nvim_set_hl(0, "NotifyERRORBorder", { bg = palette.base01, fg = palette.base08 })
    vim.api.nvim_set_hl(0, "NotifyINFOBorder", { bg = palette.base01, fg = palette.base0C })
    vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { bg = palette.base01, fg = palette.base0D })
    vim.api.nvim_set_hl(0, "NotifyWARNBorder", { bg = palette.base01, fg = palette.base0E })
  end

  vim.g.base16_palette = palette
end


