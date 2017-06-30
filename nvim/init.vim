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
set undodir=~/.local/share/nvim/undo
set backupdir=~/.local/share/nvim/backup

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

" Like 'w' and 'b' but split words in camelCase or with_underscores
noremap <silent> <C-n>
            \ :call search('\v(^\S\|\U\zs\u\|\L\zs\l)', 'sw')<CR>
noremap <silent> <C-p>
            \ :call search('\v(^\S\|\U\zs\u\|\L\zs\l)', 'bsw')<CR>

" Camel case/underscore analogs of 'e' and 'ge'
nnoremap <silent> g<C-n>
            \ :call search('\v(^\S\|\zs\U\u\|\zs\l\L)', 'sw')<CR>
nnoremap <silent> g<C-p>
            \ :call search('\v(^\S\|\zs\U\u\|\zs\l\L)', 'bsw')<CR>

" Easier way to turn off sometimes annoying highlighted searches
noremap <silent> <S-Tab> :nohlsearch<CR>
" One that works when S-Tab doesn't (e.g. in ttys)
nnoremap <silent> <Leader>n :nohlsearch<CR>

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

