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

" Decimal
syn match z80Number /\v\w@<![+\-]?\d+\w@!/

" Hexadecimal
syn match z80Number /\v\w@<![+\-]?[0-9a-f]+h\w@!/
syn match z80Number /\v\w@<![+\-]?\$[0-9a-f]+\w@!/

" Binary
syn match z80Number /\v\w@<![01]+b\w@!/
syn match z80Number /\w\w@<!\%[01]+\w@!/

syn match z80RelativeAddr /\v\$[+\-][0-9a-f]+/ contained
" Relative address after a comma and optional whitespace (not
" highlighted)
syn match z80RelAddrArg /,/ skipwhite contained nextgroup=z80RelativeAddr

syn keyword z80JRFlags z c nz nc contained skipwhite nextgroup=z80RelAddrArg
syn keyword z80AllFlags z c o v nz nc no nv contained

syn keyword z80Jump jr skipwhite nextgroup=z80JRFlags,z80RelativeAddr
syn keyword z80Jump jp call ret reti retn skipwhite nextgroup=z80AllFlags

syn keyword z80Mnemonic ex exx ld ldd lddr ldi ldir pop push
syn keyword z80Mnemonic adc add cp cpd cpdr cpi cpir cpl daa dec inc neg sbc sub
syn keyword z80Mnemonic and bit ccf or res scf set xor
syn keyword z80Mnemonic rl rla rlc rlca rld rr rra rrc rrca rrd sla sra srl
syn keyword z80Mnemonic djnz nop rst
syn keyword z80Mnemonic di ei halt im in ind indr ini otdr otir out outd outi

syn keyword z80Todo TODO contained

syn match z80Comment /;.*$/ contains=z80Todo
syn region z80String start=/"/ skip=/\\"/ end=/"/ oneline
syn match z80Character /'.'/

syn match z80Include '^\s*#include'
syn match z80Define '^\s*#define'
syn match z80Define '^\s*#undefine'
syn match z80Macro '^\s*#macro'
syn match z80Macro '^\s*#endmacro'
syn match z80CondPreProc '^\s*#if'
syn match z80CondPreProc '^\s*#ifdef'
syn match z80CondPreProc '^\s*#ifndef'
syn match z80CondPreProc '^\s*#else'
syn match z80CondPreProc '^\s*#endif'

syn match z80Directive '\v\.[a-z]+'
"syn keyword z80Directive .dr .dw .end .org .byte .word .dl .long
"syn keyword z80Directive .fill .block .addinstr .echo .error  .assume
"syn keyword z80Directive .list .nolist .show .option .seek

syn match z80Label /\v^[a-z_][a-z0-9_]*(:)@=/

" The default methods for highlighting.  Can be overridden later
hi def link z80Label        Statement
hi def link z80Comment    	Comment
hi def link z80Todo    		Todo

hi def link z80Include    	Include
hi def link z80Define    	Define
hi def link z80Macro    	Macro
hi def link z80CondPreProc  PreProc
hi def link z80Directive    PreProc

hi def link z80Number       Number
hi def link z80String    	String
hi def link z80Character    Character

hi def link z80Mnemonic    	Statement
hi def link z80Register    	Type
hi def link z80Jump         Statement
hi def link z80JRFlags    	Identifier
hi def link z80AllFlags     Identifier
hi def link z80RelativeAddr Number

let &cpo = s:cpo_save
unlet s:cpo_save
