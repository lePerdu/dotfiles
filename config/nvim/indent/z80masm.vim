" Vim indent file
" Language: Z80 Module Assembler
" Maintainer: Zach Peltzer
"

if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

set noautoindent
set indentexpr=GetZ80MASMIndent()
set indentkeys=<:>,p,h,0#,o,O

if exists('*GetZ80MASMIndent')
	finish
endif

let s:label_re = '^\s*\([a-zA-Z_][a-zA-Z0-9_]*:\|\.[a-zA-Z0-9_]\)'
let s:comment_re = '^\s*;'

function! s:GetZ80MASMPrevCodeline(lnum)
    let lnum = prevnonblank(a:lnum)
    let this_line = getline(lnum)
    while this_line =~? s:label_re || this_line =~ s:comment_re
        let lnum = prevnonblank(lnum-1)
        let this_line = getline(lnum)
    endwhile

    return lnum
endfunction

" The semantics of this are simplified, as I (as is common with assembly) indent
" with complicated, context-and-feeling-dependent rules.
" Labels are placed at column 1. Code lines are indented at least &shiftwidth.
" Everything else is placed at the same indentation as the preceding (non-label
" and non-comment) code line. It also does not change indentation of existing
" lines, even if the line should be indented differently.
function! GetZ80MASMIndent()
	let lnum = line('.')
	if lnum == 1
		return 0
	endif

	let this_line   = getline(lnum)
    let this_indent = indent(lnum)

	" Labels at column 0
	if this_line =~? s:label_re
		return 0
	endif

    " Only do other indenting for new and blank lines
    if this_line !~ '^\s*$'
        return this_indent
    endif

    let prev_lnum   = s:GetZ80MASMPrevCodeline(lnum-1)
    let prev_line   = getline(prev_lnum)
    let prev_indent = indent(prev_lnum)

    " Indent to previous code line after label
    if prev_lnum > 0
        return prev_indent
    else
        return this_indent
    endif
endfunction

