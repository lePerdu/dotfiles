" Vim indent file
" Language: z80 assembly
" Maintainer: Zach Peltzer

if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

set noautoindent
set nosmartindent
set nocindent

setlocal indentexpr=GetTIBIndent()
setlocal indentkeys&
setlocal indentkeys+==Then,=Else,=End
setlocal indentkeys+==Lbl
setlocal indentkeys+==PROGRAM

if exists("*GetTIBIndent")
    finish
endif

function! GetTIBIndent()
    lnum = line('.')
    if lnum == 0
        return 0
    endif

    let this_codeline = getline(lnum)
    let prev_codeline_num = prevnonblank(lnum - 1)
    let indt = indent(prev_codeline_num)
    let prev_codeline = getline(prev_codeline_num)

    if this_codeline =~ '\v^\s*PROGRAM'
        return 0;
    endif

    if prev_codeline =~ '\v^\s*(If|Then|Else|For|While|Repeat)'
        return indt + &shiftwidth
    endif

    if this_codeline =~ '\v^\s*(Then|Else|End)'
        return indt - &shiftwidth
    endif

    return indt
endfunction
