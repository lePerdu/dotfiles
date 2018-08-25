" Vim syntax file
" Language: Z80 Module Assembler
" Maintainer: Zach Peltzer
"

if exists('b:current_syntax')
    finish
endif

let b:current_syntax = 'z80masm'
let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn keyword z80MASMRegister a b c d e f h l i r ixh ixl iyh iyl
syn keyword z80MASMRegister af bc de hl ix iy sp

" Decimal
syn match z80MASMNumber /\w\@<![+\-]\?\d\+\w\@!/
" Hexadecimal
syn match z80MASMNumber /\w\@<![+\-]\?\$[0-9a-f]\+\w\@!/
" Binary
syn match z80MASMNumber /\w\@<!@[01]\+\w\@!/

syn match z80MASMRelativeAddr /\v\$[+-][0-9a-f]+/
" Relative address after a comma and optional whitespace (not
" highlighted)
syn match z80MASMRelAddrArg /,/ skipwhite contained nextgroup=z80MASMRelativeAddr

syn keyword z80MASMJRFlags z nz c nc contained skipwhite nextgroup=z80MASMRelAddrArg
syn keyword z80MASMAllFlags z nz c nc po pe p m contained

syn keyword z80MASMJump jr skipwhite nextgroup=z80MASMJRFlags,z80MASMRelativeAddr
syn keyword z80MASMJump jp call ret reti retn skipwhite nextgroup=z80MASMAllFlags

syn keyword z80MASMMnemonic ex exx ld ldd lddr ldi ldir pop push
syn keyword z80MASMMnemonic adc add cp cpd cpdr cpi cpir cpl daa dec inc neg sbc sub
syn keyword z80MASMMnemonic and bit ccf or res scf set xor
syn keyword z80MASMMnemonic rl rla rlc rlca rld rr rra rrc rrca rrd sla sra srl sll
syn keyword z80MASMMnemonic djnz nop rst
syn keyword z80MASMMnemonic di ei halt im in ind indr ini otdr otir out outd outi

syn keyword z80MASMTodo TODO FIXME XXX contained

syn match z80MASMComment /;.*$/ contains=z80MASMTodo
syn region z80MASMString start=/"/ skip=/\([^\\]\(\\\\\)*\)\@<=\\"/ end=/"/ oneline
syn match z80MASMCharacter /'.'/

syn keyword z80MASMDefine defb defm defw defl defc defgroup define defs defvars
syn keyword z80MASMDirective else endif if ifdef ifndef invoke lib line lstoff
" asmpc is not really a directive, but is similar
syn keyword z80MASMDirective lston module org xdef xlib xref asmpc
syn keyword z80MASMInclude binary include skipwhite nextgroup=z80MASMString

syn match z80MASMLabel /\v^\s*[a-z_][a-z0-9_]*(:)@=/
syn match z80MASMLabel /\v^\s*\.[a-z0-9_]+/

hi def link z80MASMLabel        Statement
hi def link z80MASMComment    	Comment
hi def link z80MASMTodo    		Todo

hi def link z80MASMInclude    	Include
hi def link z80MASMDefine    	Define
hi def link z80MASMMacro    	Macro
hi def link z80MASMCondPreProc  PreProc
hi def link z80MASMDirective    PreProc

hi def link z80MASMNumber       Number
hi def link z80MASMString    	String
hi def link z80MASMCharacter    Character

hi def link z80MASMMnemonic    	Statement
hi def link z80MASMRegister    	Type
hi def link z80MASMJump         Statement
hi def link z80MASMJRFlags    	Identifier
hi def link z80MASMAllFlags     Identifier
hi def link z80MASMRelativeAddr Number

let &cpo = s:cpo_save
unlet s:cpo_save
