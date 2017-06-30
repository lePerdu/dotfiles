" Vim indent file
" Language: z80 assembly
" Maintainer: Zach Peltzer

if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal indentexpr=GetZ80Indent()
setlocal indentkeys=<:>,p,h,0#,o,O

if exists("*GetZ80Indent")
	finish
endif

let s:label_re = '^\s*[a-z_][a-z0-9_]*:'
"let s:comment_re = '^\s*;'
"let s:push_re = '\v[^;]+\zs<push>'
"let s:pop_re = '\v[^;]+\zs<pop>'

function! s:GetZ80PrevNonComment(lnum)
    let lnum = prevnonblank(a:lnum)
    let this_line = getline(lnum)
    while this_line =~ s:comment_re
        let lnum = prevnonblank(lnum-1)
        let this_line = getline(lnum)
    endwhile

    return lnum
endfunction

function! s:GetZ80PrevCodeline(lnum)
    let lnum = prevnonblank(a:lnum)
    let this_line = getline(lnum)
    while this_line =~ s:label_re || this_line =~ s:comment_re
        let lnum = prevnonblank(lnum-1)
        let this_line = getline(lnum)
    endwhile

    return lnum
endfunction

function! GetZ80Indent()
	let lnum = line('.')
	if lnum == 1
		return 0
	endif

	let this_line   = getline(lnum)
    let this_indent = indent(lnum)

	" Labels at column 0
	if this_line =~ s:label_re
		return 0
	endif

    " Only do other indenting for new lines
    if this_line !~ '^\s*$'
        return this_indent
    endif

    let prev_lnum   = s:GetZ80PrevCodeline(lnum-1)
    let prev_line   = getline(prev_lnum)
    let prev_indent = indent(prev_lnum)

    let noncom_lnum     = s:GetZ80PrevNonComment(lnum-1)
    let noncom_line     = getline(noncom_lnum)

    " Indent to previous code line after label
    if noncom_line =~ s:label_re
        return max([prev_indent, &shiftwidth])
    endif

    return this_indent
endfunction

