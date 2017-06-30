" NVim init.vim file

set nobackup
set undofile

set showcmd
set ruler
set textwidth=66
set number
set cursorline
let &showbreak = '> '
set showcmd
set noesckeys
set notildeop

set smartcase
set incsearch
set hlsearch

if has('mouse')
    set mouse=a
endif

filetype on
filetype plugin indent on

syntax enable
colorscheme default

" Automatically reload vimrc when it changes
augroup ReloadVimrc
	autocmd!
	autocmd BufWritePost .vimrc,vimrc source $MYVIMRC
augroup END

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   execute "normal! g`\"" |
            \ endif

" No indent from switch to case statement.
" No indent from class declaration to public/protected/private labels.
" No Indent after  namespace declaration.
set cinoptions=:0g0N-si0

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Delete matching brackets (be careful if not on or inside the brackets)
nnoremap d\( yi(va(pl
nnoremap d\{ yi{va{pl
nnoremap d\[ yi[va[pl
nnoremap d\< yi<va<pl
nnoremap d\' yi'va'pl
nnoremap d\" yi"va"pl
nnoremap d\` yi`va`pl

function! DeleteMatch()
    let cnum = col('.')
    let lnum = line('.')
    if stridx(&matchpairs, getline('.')[cnum-1]) != -1
        normal! %
        let new_cnum = col('.')
        let new_lnum = line('.')
        " If the matching pair is before the cursor, '``' does not return
        " to the correct point
        if new_lnum > lnum || (new_cnum > cnum && new_lnum == lnum)
            normal! x``x
        else
            normal! x``hx
        endif
    endif
endfunction

" Delete current bracket and its match
nnoremap <silent> d\% :call DeleteMatch()<CR>

" Goto next character where the word changes from upper to lower case or
" vice versa.
noremap <silent> <C-n> :call search('\v(\U\zs\u\|\L\zs\l\|^\a)', 'sw')<CR>
noremap <silent> <C-p> :call search('\v(\U\zs\u\|\L\zs\l\|^\a)', 'bsw')<CR>

function! Increment()
	let lnum = line('.')
	let cnum = col('.')
	let text = getline(lnum)
	let n = text[cnum-1]

	if n =~ '\d'
		let n = str2nr(n) + 1
		if n > 9
			let n = 0
		endif
    else
        let n = nr2char(char2nr(n)+1)
	endif

    call setline(lnum, strpart(text, 0, cnum-1) . n . strpart(text, cnum, strlen(text)-cnum))
endfunction

function! Decrement()
	let lnum = line('.')
	let cnum = col('.')
	let text = getline(lnum)
	let n = text[cnum-1]

	if n =~ '\d'
		let n = str2nr(n) - 1
		if n < 0
			let n = 9
		endif
    else
        let n = nr2char(char2nr(n)-1)
	endif

    call setline(lnum, strpart(text, 0, cnum-1) . n . strpart(text, cnum, strlen(text)-cnum))
endfunction

nnoremap <silent> <C-k> :call Increment()<CR>
nnoremap <silent> <C-j> :call Decrement()<CR>

function! SwapLeft()
    let lnum = line('.')
    let cnum = col('.')
    let text = getline(lnum)

    if text[cnum-2] == '' || text[cnum-1] == ''
        return
    endif

    call setline(lnum, strpart(text, 0, cnum-1) . text[cnum-1] . text[cnum-2] . strpart(text, cnum, strlen(text) - cnum))
endfunction

function! SwapRight()
    let lnum = line('.')
    let cnum = col('.')
    let text = getline(lnum)

    if text[cnum-1] == '' || text[cnum] == ''
        return
    endif

    call setline(lnum, strpart(text, 0, cnum-1) . text[cnum] . text[cnum-1] . strpart(text, cnum+1, strlen(text) - cnum-1))
endfunction

nnoremap <silent> <C-h> :call SwapLeft()<CR>
nnoremap <silent> <C-l> :call SwapRight()<CR>

set notimeout

" Easier way to turn off sometimes annoying highlighted searches
noremap <silent> <S-Tab> :nohlsearch<CR>

" Un-indent with <S-Tab>
inoremap <S-Tab> <C-D>

" Save with sudo privileges
command! W w !sudo tee %

" Show and remove lines with only whitespace
" or ending in whitespace
command! Sw /\v\s+$/
command! Rw %s/\v\s+$//eg

" Make command which does not overwrite current buffer with errors
command! Make :!make

