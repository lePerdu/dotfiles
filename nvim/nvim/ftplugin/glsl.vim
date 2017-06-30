" Vim filetype plugin for AutoBrackets
" Language: GLSL (GL Shading Language)
"

if exists('g:loaded_autobrackets')
    call AutoBracketsAdd({'(' : ')', '[' : ']', '{' : '}'})
endif

inoremap {<CR> {<CR>}<Esc>O

setlocal noexpandtab

