" Vim filetype plugin
" Language: Literature annotation
"

setlocal textwidth=66
setlocal ignorecase

" Bindings to bold/underline word under cursor
nnoremap \_ viw<Esc>`>a_<Esc>`<i_<Esc>
nnoremap \* viw<Esc>`>a*<Esc>`<i*<Esc>
nnoremap \/ viw<Esc>`>a/<Esc>`<i/<Esc>

" Number the lines in the specified range.
" Only numbers which are multiples of the span argument are
" listed.
" Parameters:
"   range - The range (placed before the function call) to number
"   start - The number to start at
"   span - The span between numbers
"function! LitNumberLines([start = 0, [span = 5]]) range
function! LitNumberLines(...) range
    let n = exists('a:1') ? a:1 - 1: 0
    let span = exists('a:2') ? a:2 : 5
    let lnum = a:firstline - 1

    while lnum <= a:lastline
        let lnum += 1
        if getline(lnum) !~ '^[\s\t]*$'
            let n += 1
        else
            continue
        endif

        if n % span != 0
            exec lnum . 's/^/' . repeat(' ', &shiftwidth)
        else
            exec lnum . 's/^/' . n . repeat(' ', 3-float2nr(log10(n)))
        endif
    endwhile
endfunction

vnoremap <buffer> \| :'<,'>call LitNumberLines(1, 5)<CR>

