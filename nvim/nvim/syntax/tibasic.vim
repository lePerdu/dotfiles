" Vim syntax file
" Language: TI-84 BASIC
" Maintainer: Zach Peltzer

if exists('b:current_syntax')
	finish
endif

let b:current_syntax = 'tibasic'
let s:cpo_save = &cpo
set cpo&vim

syn iskeyword @,48-57,192-255,_,\\

syn keyword tibasicProgName PROGRAM

syn keyword tibasicConditional If Then Else For While Repeat End Lbl Goto IS> DS<

syn keyword tibasicSysVar Ans
syn keyword tibasicSysVar Y_1 Y_2 Y_3 Y_4 Y_5 Y_6 Y_7 Y_8 Y_9 Y_0
syn keyword tibasicSysVar X_1T Y_1T X_2T Y_2T X_3T Y_3T X_4T Y_4T X_5T Y_5T X_6T Y_6T
syn keyword tibasicSysVar r_1 r_2 r_3 r_4 r_5 r_6
syn keyword tibasicSysVar \u \v \w
syn keyword tibasicSysVar L_1 L_2 L_3 L_4 L_5 L_6
syn keyword tibasicSysVar Xmin Xmax Xscl Ymin Ymax Yscl Xres \dX \dY XFact YFact
syn keyword tibasicSysVar Tmin Tmax Tstep \thmin \thmax \thstep
syn keyword tibasicSysVar u(nMin) v(nMin) w(nMin) nMin nMax PlotStart PlotStep 

syn keyword tibasicVar A B C D E F G H I J K L M N O P Q R S T U V W X Y Z \th \n
syn keyword tibasicVar Str1 Str2 Str3 Str4 Str5 Str6 Str7 Str8 Str9 Str0
syn keyword tibasicVar GDB1 GDB2 GDB3 GDB4 GDB5 GDB6 GDB7 GDB8 GDB9 GDB0
syn keyword tibasicVar Pic1 Pic2 Pic3 Pic4 Pic5 Pic6 Pic7 Pic8 Pic9 Pic0

syn keyword tibasicConst \e \i \pi

syn match tibasicOperator /\v\-\>/
syn match tibasicOperator /\v\+/
syn match tibasicOperator /\v\-/
syn match tibasicOperator /\v\*/
syn match tibasicOperator /\v\//

syn match tibasicNumber /\v\d*(\.\d*)?(E\-?\d{1,2})?/

syn region tibasicString start=/\v"/ end=/\v["\n]/

" Stop those commands from having the '1' highlighted
syn keyword tibasicFunc Px1 px1

hi def link tibasicProgName     PreProc
hi def link tibasicConditional  Statement
hi def link tibasicOperator     Operator
hi def link tibasicVar          Type
hi def link tibasicSysVar       Type
hi def link tibasicString       String
hi def link tibasicNumber       Number
hi def link tibasicConst        Constant

let &cpo = s:cpo_save
unlet s:cpo_save
