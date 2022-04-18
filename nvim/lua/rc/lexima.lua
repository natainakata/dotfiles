vim.cmd[[
let s:rules = []
" let s:rules += [
" \ { 'filetype': 'python', 'char': "f'", 'input_after': "'"},
" \ { 'filetype': 'python', 'char': "<BS>", 'at': "f'\%#'", 'delete': 1}
"\ ]
for s:rule in s:rules
  call lexima#add_rule(s:rule)
endfor
]]
