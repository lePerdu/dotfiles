" Vim syntax file
" Language: brainfuck
" Maintainer: Zach Peltzer

if exists('b:current_syntax')
    finish
endif

let b:current_syntax = 'brainfuck'

" Define first for lowest priority
syn match brainfuckComment "."

syn match brainfuckOperator "+"
syn match brainfuckOperator "-"
syn match brainfuckMove "<"
syn match brainfuckMove ">"
syn match brainfuckLoop "\["
syn match brainfuckLoop "]"
syn match brainfuckIO ","
syn match brainfuckIO "\."

" The default methods for highlighting.  Can be overridden later
hi def link brainfuckComment    Comment
hi def link brainfuckOperator   Operator
hi def link brainfuckMove       Statement
hi def link brainfuckLoop       Conditional
hi def link brainfuckIO         Statement

