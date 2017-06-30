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

setlocal indentexpr=GetTIBIndent(v:lnum)
setlocal indentkeys=o,O
setlocal indentkeys+==Then,=Else,=End,=Lbl

if exists("*GetTIBIndent")
    finish
endif

function! GetTIBIndent(lnum)
    if a:lnum == 1
        return 0
    endif

    let this_codeline = getline(a:lnum)

    let prev_codeline_num = prevnonblank(a:lnum - 1)
    let indt = indent(prev_codeline_num)
    let prev_codeline = getline(prev_codeline_num)

    let prev2_codeline_num = prevnonblank(prev_codeline_num - 1)
    let indt2 = indent(prev2_codeline_num)
    let prev2_codeline = getline(prev2_codeline_num)

    if this_codeline =~ '\v^\s*PROGRAM'
        return 0;
    endif

    if this_codeline =~ '\v^\s*Then' && prev_codeline =~ '\v^\s*If'
        return indt
    endif

    if this_codeline =~ '\v^\s*Else'
        if prev_codeline =~ '\v^\s*Then'
            return indt
        else
            return indt - &shiftwidth
        endif
    endif

    " End of a conditional
    " If the line before it contains the conditoinal statement,
    " remain on the same indentation; otherwise, de-indent back to the
    " conditional
    if this_codeline =~'\v^\s*End'
        if prev_codeline =~ '\v^\s*(If|Then|Else|For|While|Repeat)'
            return indt
        elseif prev_codeline !~ '\v^\s*Then' && prev2_codeline =~ '\v^\s*If[^:]+$'
            return indt2 - &shiftwidth
        else
            return indt - &shiftwidth
        endif
    endif

    " Single-line If statement with no Then
    if prev_codeline =~ '\v^\s*If[^:]+\:\s*(Then)@!'
        return indt
    endif

    " Two-(code)line If statement with no Then
    if prev2_codeline =~ '\v^\s*If[^:]+$' && prev_codeline !~ '\v^\s*Then'
        return indt2
    endif

    " Indent after conditonals (non-special Ifs)
    if prev_codeline =~ '\v^\s*(If|Then|Else|For|While|Repeat)'
        return indt + &shiftwidth
    endif

    return indt
endfunction

