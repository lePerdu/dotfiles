" Vim filetype plugin for HTML tag completion
" Language: HTML

" Autocomplete tags when '>' is pressed
inoremap >< ></<C-X><C-O><Esc>?</<CR>:noh<CR>i
" Indent also if enter is pressed
inoremap ><CR> ></<C-X><C-O><Esc>?</<CR>:noh<CR>i<CR><CR><Up><Tab>

