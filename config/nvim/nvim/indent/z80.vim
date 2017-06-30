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

setlocal indentexpr=GetZ80Indent()
setlocal indentkeys=<:>,0#,o,O

if exists("*GetZ80Indent")
	finish
endif

function! GetZ80Indent()
	let lnum = line('.')
	if lnum == 1
		return 0
	endif

    let prev_lnum = prevnonblank(lnum-1)

	let this_codeline = getline(lnum)

	" Pre-processor commands at column 0
	if this_codeline =~ '\s*#[a-z]*'
		return 0
	endif

	" Labels at column 0
	if this_codeline =~ '\s*[a-z_][a-z0-9_]*:'
		return 0
	endif

	let prev_codeline = getline(prev_lnum)

	" Indent after a label
	if prev_codeline =~ '[a-z_][a-z0-9_]*:'
		return &shiftwidth
	endif

	" Everything else is same as previous line
	return indent(prev_lnum)
endfunction

