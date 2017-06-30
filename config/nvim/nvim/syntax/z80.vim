" Vim syntax file
" Language: z80 assembly
" Maintainer: Zach Peltzer

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = 'z80'
let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn keyword z80Register a b c d e f h l i r ixh ixl
syn keyword z80Register af bc de hl ix iy sp

syn keyword z80Flags z nz c nc m p contained skipwhite
syn keyword z80Jump jr jp call ret reti retn nextgroup=z80Flags,z80RelativeAddr skipwhite

syn keyword z80Mnemonic ex exx ld ldd lddr ldi ldir pop push
syn keyword z80Mnemonic adc add cp cpd cpdr cpi cpir cpl daa dec inc neg sbc sub
syn keyword z80Mnemonic and bit ccf or res scf set xor
syn keyword z80Mnemonic rl rla rlc rlca rld rr rra rrc rrca rrd sla sra srl
syn keyword z80Mnemonic djnz nop rst
syn keyword z80Mnemonic di ei halt im in ind indr ini otdr otir out outd outi

syn match z80RelativeAddr /\v\$[+\-][0-9a-f]+/ contained

syn match z80DecNumber /\v\w@<![+\-]?\d+\w@!/

syn match z80HexNumber /\v\w@<![+\-]?[0-9a-f]+h\w@!/
syn match z80HexNumber /\v\w@<![+\-]?\$[0-9a-f]+\w@!/

syn match z80BinNumber /\v\w@<![01]+b\w@!/
syn match z80BinNumber /\w\w@<!\%[01]+\w@!/

syn keyword z80Todo contained TODO

syn region z80Comment start=/;/ end=/$/ contains=z80Todo
"syn match z80Comment /;.*$/ contains=z80Todo
syn region z80String start=/"/ end=/"/
syn match z80Character /'.'/

syn match z80Include '^#include'
syn match z80Define '^#define'
syn match z80Macro '^#macro'
syn match z80Macro '^#endmacro'
syn match z80CondPreProc '^#if'
syn match z80CondPreProc '^#ifdef'
syn match z80CondPreProc '^#ifndef'
syn match z80CondPreProc '^#endif'

syn match z80Directive '\v\.[a-z]+'

syn match z80Label /\v^[a-z_][a-z0-9_]*(:)@=/

" The default methods for highlighting.  Can be overridden later
hi def link z80Label		Statement
hi def link z80Comment		Comment
hi def link z80Todo			Todo

hi def link z80Include		Include
hi def link z80Define		Define
hi def link z80Macro		Macro
hi def link z80CondPreProc	PreProc
hi def link z80Directive	PreProc

hi def link z80HexNumber	Number
hi def link z80DecNumber	Number
hi def link z80BinNumber	Number
hi def link z80String		String
hi def link z80Character	Character

hi def link z80Mnemonic		Statement
hi def link z80Register		Type
hi def link z80Jump         Conditional
hi def link z80Flags		Identifier
hi def link z80RelativeAddr Number

let &cpo = s:cpo_save
unlet s:cpo_save
