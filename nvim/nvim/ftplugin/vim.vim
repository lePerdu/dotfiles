" Vim filetype plugin for AutoBrackets
" Language: Vimscript

if exists('g:loaded_autobrackets')
    call AutoBracketsAdd({ '(': ')', '[': ']', '{' : '}', "'": "'"}) 
endif

