" Vim plugin for autocompleting brackets
"

if exists('g:loaded_autobrackets')
    finish
endif

let g:loaded_autobrackets = 1

if !exists('g:autobrackets_pairs')
    let g:autobrackets_pairs = {}
endif

" Action for the backspace (<BS>) key.
" In the situation:
"   (|), for any initialized bracket types
" the result will be
"   |
"
" Otherwise, the result will be the normal one for <BS>
function! AutoBracketsBackSpace()
    let text = getline('.')
    let cnum = col('.')

    for [o, c] in items(g:autobrackets_pairs)
        if strpart(text, cnum-len(o)-1, len(o)) == o && strpart(text, cnum-1, len(c)) == c
            return repeat("\<BS>", len(o)) . repeat("\<Del>", len(c))
        endif
    endfor

    return "\<BS>"
endfunction

" Creates mappings to autocomplete the specified bracket pairs.
function! AutoBracketsAdd(pairs)
    if len(a:pairs) != 0
        inoremap <expr> <BS> AutoBracketsBackSpace()
        call extend(g:autobrackets_pairs, a:pairs)
    endif

    for [o, c] in items(a:pairs)
        " Escaped (if needed) the closing character.
        let c_esc = c == '"' ? '\'.c : c

        " Complete brackets in insert mode
        execute 'inoremap' o.c o.c
        execute 'inoremap' o.'\' o
        execute 'inoremap' o.'<BS>' '<Nop>'
        if o !=# c
            execute 'inoremap' o o.c.'<Left>'
            execute 'inoremap <expr>' c 'strpart(getline("."), col(".")-1, 1) == "'.c_esc.'" ? "<Right>" : "'.c_esc.'"'
        else
            execute 'inoremap <expr>' o 'strpart(getline("."), col(".")-1, 1) == "'.c_esc.'" ? "<Right>" : "'.c_esc.c_esc.'<Left>"'
        endif

        " Surround visual selection with brackets
        execute 'vnoremap' '\'.o '<Esc>`>'.v:count.'a'.c.'<Esc>`<'.v:count.'i'.o.'<Esc>'
    endfor
endfunction

" Removes all mappings created by AutoBracketsAdd() for the
" specified pairs.
function! AutoBracketsRemove(pairs)
    for [o, c] in items(a:pairs)
        if has_key(g:autobrackets_pairs, o) && g:autobrackets_pairs[o] == c
            exec 'iunmap' o
            exec 'iunmap' c
            exec 'iunmap' o.'\'
            exec 'iunmap' o.'<BS>'
            exec 'vunmap' '\'.o

            unlet g:autobrackes_pairs[o]
        endif
    endfor

    if len(g:autobrackets_pairs) == 0
        iunmap <BS>
    endif
endfunction

