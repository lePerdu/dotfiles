" Vim filetype plugin
" Language: Javascript

" Continue triple-slash comments properly (has to be placed before double-slash)
set comments-=://
set comments+=:///,://

let b:match_words = '\<if\>:\<else\>,'
			\ . '\<do\>:\<break\>:\<continue\>:\<while\>,'
			\ . '\<while\>:\<break\>:\<continue\>,'
			\ . '\<switch\>:\<case\>:\<default\>,'
			\ . '\<import\>:\<from\>,'
			\ . '?:\:'

