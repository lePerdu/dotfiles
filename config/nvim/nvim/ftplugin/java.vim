" Vim filetype plugin
" Language: Java

if exists('g:loaded_autobrackets')
    call AutoBracketsAdd({'(' : ')', '[' : ']', '{' : '}', "'": "'", '"' : '"'})
endif

inoremap {<CR> {<CR>}<Esc>O

