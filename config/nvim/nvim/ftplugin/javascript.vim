" Vim filetype plugin
" Language: JavaScript (ECMAScript6)

if exists('g:loaded_autobrackets')
    call AutoBracketsAdd({'(' : ')', '[' : ']', '{' : '}', "'": "'", '"' : '"', '`' : '`'})
endif

inoremap {<CR> {<CR>}<Esc>O
inoremap [<CR> [<CR>]<Esc>O

