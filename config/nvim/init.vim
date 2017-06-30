" NeoVim init.vim file

set showcmd
set noshowmode
set textwidth=80
set colorcolumn=+1
set cursorline
set number
let &showbreak = '> '
set notildeop

set ignorecase
set smartcase
set incsearch
set hlsearch

set splitright
set nostartofline

set nojoinspaces
set autowrite
set undofile
set backup
set undodir=~/.local/share/nvim/undo,.
set backupdir=~/.local/share/nvim/backup,.

set formatoptions=tcroqj
set pastetoggle=<F10>

set mouse=a
set clipboard=unnamed,unnamedplus

" Do not end sentence after capital letter, exclamation point, or
" question mark
set spellcapcheck=\l\.\_[\])'"\t ]

filetype on
filetype plugin indent on

syntax enable

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

set notimeout
let mapleader = '\'

function! s:SearchCount(expr, flags)
	for i in range(v:count1)
		call search(a:expr, a:flags)
	endfor
endfunction

" Like 'w' and 'b' but split words in camelCase or with_underscores
noremap <silent> <C-n>
            \ :<C-U>call <SID>SearchCount('\v(^\S\|\U\zs\u\|\L\zs\l)', 'sw')<CR>
noremap <silent> <C-p>
            \ :<C-U>call <SID>SearchCount('\v(^\S\|\U\zs\u\|\L\zs\l)', 'bsw')<CR>

" Camel case/underscore analogs of 'e' and 'ge'
nnoremap <silent> g<C-n>
            \ :<C-U>call <SID>SearchCount('\v(^\S\|\zs\U\u\|\zs\l\L)', 'sw')<CR>
nnoremap <silent> g<C-p>
            \ :<C-U>call <SID>SearchCount('\v(^\S\|\zs\U\u\|\zs\l\L)', 'bsw')<CR>

function! s:ConvertCamelUnderscore()
	let l:lnum = line('.')
	let l:col = col('.')
	let l:text = getline(l:lnum)
	let l:linelen = strlen(l:text)

	if l:text[l:col-1] !~ '\w'
		return
	endif

	let l:startpos = l:col-1
	while l:text[l:startpos-1] =~ '\w' && l:startpos-1 > 0
		let l:startpos -= 1
	endwhile

	let l:endpos = l:col-1
	while l:text[l:endpos+1] =~ '\w'
		let l:endpos += 1
	endwhile

	let l:str = l:text[l:startpos:l:endpos]
	let l:leading = matchstr(l:str, '^_*')
	let l:following = matchstr(l:str, '_*$')
	let l:str = l:str[strlen(l:leading):-strlen(l:following)-1]
	" Length of string up to cursor position
	let l:collen = l:col - l:startpos
	if match(l:str, '\a_\+\a') >= 0
		" Underscore separated

		" Multiple underscores are removed together
		let l:us_split = split(l:str, '_\+')
		let l:start_caps = 0
		if l:str[0] =~ '\u'
			let l:start_caps = 1
		endif

		let l:str = ""
		for l:part in l:us_split
			let l:str .= toupper(l:part[0]) . l:part[1:]

			if strlen(l:str) <= l:collen
				let l:collen -= 1
			endif
		endfor

		if !l:start_caps
			let l:str = tolower(l:str[0]) . l:str[1:]
		endif
	else
		" Camel case

		let l:cc_split = split(l:str, '\(\ze\u\l\|\l\zs\ze\L\)')

		" Whether or not the names should be made to start with lower case
		let l:lower = 0
		if l:cc_split[0] =~ '^\l'
			let l:lower = 1
		endif

		let l:str = ""
		for l:part in l:cc_split
			if l:lower && l:part !~ '^\L\L\+$'
				let l:str .= tolower(l:part[0]) . l:part[1:] . '_'
			else
				let l:str .= l:part . '_'
			endif

			if strlen(l:str) <= l:collen
				let l:collen += 1
			endif
		endfor
		let l:str = l:str[:-2]
	endif

	call setline(l:lnum, l:text[0:l:startpos-1] .
				\ l:leading . l:str . l:following .
				\ l:text[l:endpos+1:])
	call cursor(l:lnum, l:startpos + l:collen)
endfunction

" Turn current word from camelCase into underscore_separated and vice versa.
nnoremap <silent> <Leader>_ :call <SID>ConvertCamelUnderscore()<CR>

" Global search and replace
nnoremap <Leader>s :<C-U>%s//g<Left><Left>
" '<,'> is implicit when entering command mode from visual mode
vnoremap <Leader>s :s//g<Left><Left>


" Easier way to turn off sometimes annoying highlighted searches
noremap <silent> <S-Tab> :nohlsearch<CR>
" One that works when S-Tab doesn't (e.g. in ttys)
nnoremap <silent> <Leader>n :nohlsearch<CR>

" Move tabs
" Moving a tab past the end results in the tab being wrapped to the other side
nnoremap <silent> g> :<C-U>try \| execute 'tabmove +' . v:count1 \| catch \| tabmove 0 \| endtry<CR>
nnoremap <silent> g< :<C-U>try \| execute 'tabmove -' . v:count1 \| catch \| tabmove \| endtry<CR>

" Save with sudo privileges
command! WriteSudo w! !sudo tee % > /dev/null
cabbrev Ws WriteSudo

" Show and remove lines with only whitespace
" or ending in whitespace
command! SearchWhite /\v\s+$/
cabbrev Sw SearchWhite
command! RemoveWhite %s/\v\s+$//eg
cabbrev Rw RemoveWhite

call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

call plug#end()

let g:deoplete#enable_at_startup = 1

if $TERM =~ '.*256color'
    set termguicolors
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,
                \a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,
                \sm:block-blinkwait175-blinkoff150-blinkon175
    autocmd VimLeave *
                \ set guicursor=a:ver25-blinkwait700-blinkoff250-blinkon200

    let g:onedark_termcolors = 256
    let g:onedark_terminal_italics = 1
else
    let g:onedark_termcolors = 16
    let g:onedark_terminal_italics = 0
endif

let g:airline_theme = 'onedark'
let g:airline_symbols_ascii = 1
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline#extensions#tabline#left_sep = '>'
let g:airline#extensions#tabline#right_sep = '<'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 2

colorscheme onedark

