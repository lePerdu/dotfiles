" Syntax file for Literature annotations
"

syn region litComment start='#' end='$' contains=@NoSpell

syn match litItalic '/.*/'
syn match litBold '\*.*\*'
syn match litUnderline '_.*_'

hi def litItalics   term=italic cterm=italic gui=italic
hi def litBold      term=bold cterm=bold gui=bold
hi def litUnderline term=underline cterm=underline gui=underline

hi def link litComment  Comment

let b:current_syntax='literature'

