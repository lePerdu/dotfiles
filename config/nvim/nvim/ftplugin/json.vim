" Vim filetype plugin
" Language: JSON

if exists('g:loaded_autobrackets')
    call AutoBracketsAdd({'(' : ')', '[' : ']', '{' : '}', '"' : '"'})
endif

inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>]<Esc>O

setlocal noexpandtab

