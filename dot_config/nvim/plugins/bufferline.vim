UsePlugin 'bufferline.nvim'
" bufferline
lua << EOF
require("bufferline").setup{
  options = {
    diagnostics = "coc",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    separator_style = "slant",
    offsets = {{ filetype = "fern", text = "File Explorer", text_align = "center" }}
  }
}
EOF

nnoremap <silent>gt :BufferLineCycleNext<CR>
nnoremap <silent>gT :BufferLineCyclePrev<CR>

nnoremap <silent>[b :BufferLineMoveNext<CR>
nnoremap <silent>b] :BufferLineMovePrev<CR>

nnoremap <silent>be :BufferLineSortByExtension<CR>
nnoremap <silent>bd :BufferLineSortByDirectory<CR>
nnoremap <silent><mymap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>


