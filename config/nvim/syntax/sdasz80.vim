" Vim syntax file
" Language: z80 assembly for sdcc/sdasz80
" Maintainer: Zach Peltzer

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = 'sdasz80'
let s:cpo_save = &cpo
set cpo&vim

syn case ignore

syn keyword z80Register a b c d e f h l i r ixh ixl
syn keyword z80Register af bc de hl ix iy sp pc

syn keyword z80Flags z nz c nc m p contained
syn keyword z80Jump jr jp call ret reti retn nextgroup=z80Flags skipwhite

syn keyword z80Mnemonic ex exx ld ldd lddr ldi ldir pop push
syn keyword z80Mnemonic adc add cp cpd cpdr cpi cpir cpl daa dec inc neg sbc sub
syn keyword z80Mnemonic and bit ccf or res scf set xor
syn keyword z80Mnemonic rl rla rlc rlca rld rr rra rrc rrca rrd sla sra srl
syn keyword z80Mnemonic djnz nop rst
syn keyword z80Mnemonic di ei halt im in ind indr ini otdr otir out outd outi

syn match z80Immediate '\v\#\w*'

syn match z80Number '\v<[+\-]?\d+>'
syn match z80Number '\v<[+\-]?0x[0-9a-f]+>'
syn match z80Number '\v<[+\-]?0[0-7]+>'
syn match z80Number '\v<[+\-]?0b[01]+>'

syn keyword z80Todo TODO contained 

syn region z80Comment start=';' end='$' contains=z80Todo
syn region z80String start='"' end='"'
syn match z80Character "'.'"

syn match z80Directive '\v^\s*\zs\.[a-z]+'
syn match z80Directive '\v^\s*[a-z_][a-z_0-9]*\s*\zs\.equ'

syn match z80Label '\v^[a-z_\.][a-z0-9_]*:@='
syn match z80Label '\v^\d+\$:@='

" The default methods for highlighting.  Can be overridden later
hi def link z80Label		Statement
hi def link z80Directive    PreProc
hi def link z80Comment		Comment
hi def link z80Todo			Todo

hi def link z80Number	    Number
hi def link z80Immediate    Number
hi def link z80String		String
hi def link z80Character	Character

hi def link z80Mnemonic		Statement
hi def link z80Register		Type
hi def link z80Jump         Conditional
hi def link z80Flags		Identifier

let &cpo = s:cpo_save
unlet s:cpo_save
