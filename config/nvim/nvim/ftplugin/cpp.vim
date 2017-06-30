" Vim filetype plugin
" Language: C++

if exists('g:loaded_autobrackets')
    call AutoBracketsAdd({'(' : ')', '[' : ']', '{' : '}', "'": "'", '"' : '"'})
endif

inoremap {<CR> {<CR>}<Esc>O

" Stop annoying movement after namespace/class names
inoremap :: ::

