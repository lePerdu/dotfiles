" Filetype pluging for LaTeX command completion
" Language: (La)TeX
"

if exists('g:loaded_autobrackets')
    call AutoBracketsAdd({ '{': '}', '[': ']', '(': ')', '`': "'", '``': "''" })
endif

" Called after '}' is typed.
" If the preceding text is '\end{', then the text is searched backwards
" to find the last '\begin' command in order to complete the end command
" with the correct environment.
"function! LaTeXCompleteEnviron()
"    " If did not type '}'
"    if v:char != '}'
"        return
"    endif
"
"    let lnum = line('.')
"    let cnum = col('.')
"    let text = getline(lnum)
"
"    " If not preceded by '\end{'
"    if strpart(text, cnum-5, cnum-1) != '\end{'
"        return
"    endif
"
"    " Truncate to before '\end{'
"    let text = strpart(text, 0, cnum-6)
"
"    while lnum >= 0
"        let text = getline('.')
"        let text = strpart(text, 0, stridx(text, '%'))
"
"    endwhile
"endfunction
"
