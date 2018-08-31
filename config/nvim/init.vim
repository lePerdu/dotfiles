" NeoVim init.vim file
"

" Options {{{
set title
set showcmd
set noshowmode
set laststatus=2
set showtabline=2
set modelines=1
set shortmess+=c

set textwidth=80
set colorcolumn=+1
" To avoid jumping back and forth when using ALE
set signcolumn=yes
set cursorline
set number
let &showbreak = '> '
set isfname-==

set ignorecase
set smartcase
set incsearch
set hlsearch
set hidden
set scrolloff=1
set switchbuf=usetab

set splitright
set nostartofline
set foldmethod=marker

set nojoinspaces
set undofile
set autowrite
set backup
set undodir=~/.local/share/nvim/undo,.
set backupdir=~/.local/share/nvim/backup,.

set formatoptions=tcroqj
set pastetoggle=<F10>

" Do not end sentence after capital letter, exclamation point, or
" question mark
set spellcapcheck=\l\.\_[\])'"\t ]

if has('mouse')
    set mouse=a
endif

if has('clipboard')
    set clipboard=unnamed,unnamedplus
endif

if $COLORTERM == "truecolor" || $COLORTERM == "24bit"
    set termguicolors
endif

if $TERM =~ '.*256color' || &termguicolors
    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,
                \a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,
                \sm:block-blinkwait175-blinkoff150-blinkon175
    autocmd VimLeave *
                \ set guicursor=a:ver25-blinkwait700-blinkoff250-blinkon200
endif

filetype on
filetype plugin indent on
syntax enable

" No indent from switch to case statement.
" Blocks after case statements are indented like any other statement.
" No indent from class declaration to public/protected/private labels.
" No indent after namespace declaration.
" No indent after extern declaration (for C++)
" No indent of K&R-style parameter declarations (also applies to C++ initializer
" lists, after which vim does not indent the constructor body correctly if this
" is set set).
" Put closing parenthesis at the indentation of the line with the opening one.
"
" As an example of mose of these: {{{
"
"   extern "C" {
"
"   namespace ns {
"
"   class A {
"   public:
"     A(int a1, int a2);
"   private:
"     int a;
"   };
"
"   A::A()
"   : A(1, 0) {}
"
"   A::A(int a1, int a2)
"   : a(a1 + a2) {}
"
"   int main() {
"       int i1,
"           i2;
"       float f1,
"             f2;
"       A *b;
"       if (i1
"               && i2) {
"           b = new A(
"               a1,
"               a2
"           );
"       }
"
"       if (f1 >= f2
"               && f1 != fs
"       ) {
"           b = new A(a1,
"                     a2);
"       }
"
"       i1 = i2 +
"            f2 -
"            f1;
"
"       switch (i2) {
"       case 0:
"           return 0;
"       case 1: {
"           int i3 = 2;
"           break;
"       }
"       default:
"           return 1;
"       }
"
"       return 0;
"   }
"
"   }
"
"   }
" }}}
"
set cinoptions=:0l1g0N-si0E-sp0m1k2s

set copyindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set notimeout
let mapleader = '\'

" let $XDG_CONFIG_HOME="~/.config"
" set runtimepath=$XDG_CONFIG_HOME/nvim,$VIM,$VIMRUNTIME,$XDG_CONFIG_HOME/nvim/after

" }}}

" Mappings {{{

noremap <silent> <F9> :<C-U>set spell!<CR>
inoremap <silent> <F9> <C-O>:set spell!<CR>

" Don't need ex mode and it's annoying to accidentally go into it
nnoremap Q <nop>

" Delete buffer
nnoremap <Leader>q :bdelete<CR>

" Move based on screen lines (for wrapped lines)
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" This makes more sense and yy already yanks the whole line
nnoremap Y y$

" Start a global substitute command
nnoremap <Leader>s :%s//g<Left><Left>
" '<,'> is implicit when entering command mode from visual mode
vnoremap <Leader>s :s//g<Left><Left>

" Start a global substitute command for the word under the cursor (search
" pattern from * command).
nnoremap <Leader>S :%s/\<<C-R><C-W>\>//g<Left><Left>
" Start a global substitute command for the text selected.
" TODO Find a way to not take up a register
vnoremap <Leader>S y:%s/<C-R>"//g<Left><Left>

vnoremap <Leader>T :sort<Space>

" Don't exit visual mode when changing indent
vnoremap > >gv
vnoremap < <gv

" TODO Support repeat.vim
function! s:SwapLeft()
    let l:col = col('.')
    if l:col < 2
        return
    endif

    let l:lnum = line('.')
    let l:line = getline(l:lnum)

    call setline(l:lnum, strpart(l:line, 0, l:col-2) . l:line[l:col-1] . l:line[l:col-2] . strpart(l:line, l:col))
endfunction

" Swap adjacent characters/lines
" TODO Add counts
nnoremap <silent> <C-H> :call <SID>SwapLeft()<CR>h
nnoremap <silent> <C-K> :.-1move .<CR>k=j
nnoremap <silent> <C-J> :.move .+1<CR>=kj
nnoremap <silent> <C-L> l:call <SID>SwapLeft()<CR>

" Moving between pieces of snake_case and camelCase words
" If not inside such a word, this scans between WORDS like the W and B mappings
" (for the most part)
function! s:SearchBreak(flags)
    " Search for:
    "   _[0-9A-Za-z] - Underscore followed by an alphanumeric
    "   [0-9a-z]\u - Lower case followed by upper case
    "   \D\d - Non-number followed by number
    "   \s\S - Start of WORD (by normal vim interpretation)
    "   ^ - Start of next line
    for i in range(1, v:count1)
        call search('\v_\zs[0-9A-Za-z]|[0-9a-z]\zs\u|\D\zs\d|\s\zs\S|^', a:flags)
    endfor
endfunction

noremap <silent> <C-N> :<C-U>call <SID>SearchBreak('')<CR>
noremap <silent> <C-P> :<C-U>call <SID>SearchBreak('b')<CR>

nnoremap <Leader>= <C-^>

" Join lines with a backslash.
" TODO Make the character configurable.
" TODO Add count
nnoremap <Leader>J A \ <Esc>J

" Easier way to turn off sometimes annoying highlighted searches
noremap <silent> <S-Tab> :nohlsearch<CR>
" One that works when S-Tab doesn't (e.g. in ttys)
nnoremap <silent> <Leader>n :nohlsearch<CR>

" Reverse line feed (not all mappings are sent by all terminals)
inoremap <S-Return> <C-O>O
inoremap <C-Return> <C-O>O
inoremap <M-Return> <C-O>O

" Save with sudo privileges
command! WriteSudo w !sudo tee % > /dev/null
cabbrev w!! WriteSudo

command! WriteSudoQuit WriteSudo | q!
cabbrev wq!! WriteSudoQuit

" Show and remove lines with only whitespace
" or ending in whitespace
command! SearchWhite /\v\s+$/
cabbrev Sw SearchWhite
command! RemoveWhite %s/\v\s+$//eg
cabbrev Rw RemoveWhite

" Some abbreviations for common things I mistype
iabbrev fo of
iabbrev Fo Of
iabbrev teh the
iabbrev Teh The

" Exit out of terminal input mode easier
tnoremap <Esc> <C-\><C-N>

" }}}

" Functions/Autocommands {{{

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   execute "normal! g`\"" |
            \ endif

" Last modification update {{{
" TODO Make this a plugin
" TODO Integrate with vim-repeat

" Variable to tell whether to update the last modified date or not.
let g:update_last_mod = 1
" Toggle the value
nnoremap <silent> <F7> :let g:update_last_mod = !g:update_last_mod<CR>

" Update last modification date when writing
" TODO Find a way to undo this (since it will redo itself at the next write) and
" also to make it not add to the undo list
function! s:UpdateLastModified()
    if !&modified || !g:update_last_mod
        return
    endif

    " Backup the cursor position to restor it after the substitution
    let cur_backup = getpos('.')

    " Only replace up to the first non-blank line
    call cursor(1, 1)
    let firstblank_lnum = search('^\s*$', 'n')
    if firstblank_lnum == 0
        let firstblank_lnum = line('$')
    endif

    let lastmod_lnum = search('Last Modified: ', 'n', firstblank_lnum)
    if lastmod_lnum > 0
        let cur_line = getline(lastmod_lnum)
        let new_line = substitute(cur_line,
                    \ 'Last Modified: .*',
                    \ 'Last Modified: ' . strftime('%a, %d %b %Y'),
                    \ '')
        if cur_line != new_line
            " Only change if it is different to avoid cluttering the undo
            " sequence.
            call setline(lastmod_lnum, new_line)
        endif
    endif

    call setpos('.', cur_backup)
endfunction
autocmd BufWritePre * call <SID>UpdateLastModified()
" }}}

" }}}

" Plugins {{{

set runtimepath+=/home/zach/.config/nvim/dein/dein.vim

let g:dein#install_log_filename = "~/.config/nvim/dein/install.log"

" Required:
if dein#load_state('/home/zach/.config/nvim/dein')
    call dein#begin('/home/zach/.config/nvim/dein')

    " Let dein manage dein
    " Required:
    call dein#add('/home/zach/.config/nvim/dein/dein.vim')

    call dein#add('joshdick/onedark.vim')
    " call dein#add('edkolev/tmuxline.vim')
    " call dein#add('kovisoft/slimv')
    " call dein#add('l04m33/vlime')
    " call dein#add('neomake/neomake')
    call dein#add('rust-lang/rust.vim')
    call dein#add('Shougo/deoplete.nvim', {
                \ 'hook_post_update': 'call dein#remote_plugins()'
                \ })
    " call dein#add('Yggdroot/indentLine')
    " call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('junegunn/fzf', {
                \ 'build': './install --bin'
                \ })
    call dein#add('junegunn/fzf.vim')
    call dein#add('donRaphaco/neotex', {
                \ 'on_ft': 'tex',
                \ })
    call dein#add('sgur/vim-editorconfig')
    call dein#add('embear/vim-localvimrc')
    call dein#add('lilydjwg/colorizer')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('lervag/vimtex')
    call dein#add('noahfrederick/vim-skeleton')
    call dein#add('romainl/vim-qf')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('tpope/vim-abolish')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-unimpaired')
    " call dein#add('w0rp/ale')
    " call dein#add('ludovicchabant/vim-gutentags')
    call dein#add('Shougo/echodoc.vim')
    " call dein#add('justinmk/vim-dirvish')
    call dein#add('dag/vim-fish')
    call dein#add('pangloss/vim-javascript')
    call dein#add('mxw/vim-jsx')
    call dein#add('autozimu/LanguageClient-neovim', {
                \ 'rev': 'next',
                \ 'build': 'bash install.sh',
                \ })
    call dein#add('scrooloose/nerdtree')
    call dein#add('Xuyuanp/nerdtree-git-plugin')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')


    " Required:
    call dein#end()
    call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" This is needed again after dein initialization, for some reason
filetype plugin indent on
syntax enable

" Multicolor {{{

if $TERM =~ '.*256color' || &termguicolors
    let g:multicolor_termcolors = 256
    let g:multicolor_terminal_italics = 1
    " let g:multicolor_disable_background = 1
else
    let g:multicolor_termcolors = 16
    let g:multicolor_terminal_italics = 0
endif

" colorscheme multicolor

" }}}

" Onedark {{{

if $TERM =~ '.*256color' || &termguicolors
    let g:onedark_termcolors = 256
    let g:onedark_terminal_italics = 1
else
    let g:onedark_termcolors = 16
    let g:onedark_terminal_italics = 0
endif

colorscheme onedark

" }}}

" NERDTree {{{

nnoremap <Leader>N :NERDTreeToggle<CR>
" call NERDTreeAddKeyMap({
"             \ 'key': 'l',
"             \ 'callback': "NERDTreeMapActivateNode"})
let g:NERDTreeMapActivateNode = 'l'
let g:NERDTreeMapOpenRecursively = 'L'
let g:NERDTreeMapCloseDir = 'h'
let g:NERDTreeMapCloseChildren = 'H'

" }}}

" Ctrl-P {{{
" let g:ctrlp_map = '<Leader><C-P>'
" }}}

" FZF {{{
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :GFiles<CR>
nnoremap <Leader>b :Buffers<CR>

let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit',
            \ }

let g:fzf_buffers_jump = 1

" }}}

" Deoplete {{{
let g:deoplete#enable_at_startup = 1

" let g:deoplete#souces = {
"             \ '_': ['buffer', 'tags', 'file', 'around'],
"             \ 'c': ['buffer', 'file', 'around'],
"             \ 'cpp': ['buffer', 'file', 'around'],
"             \ 'javascript': ['buffer', 'file', 'around'],
"             \ }

" Tab and Shift-Tab instead of <C-N> and <C-P>
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"

" Enter inserts new line (not select match)
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" }}}

" LanguageClient-neovim {{{

let g:LanguageClient_serverCommands = {
            \ 'c': ['cquery'],
            \ 'cpp': ['cquery'],
            \ 'javascript': ['javascript-typescript-stdio'],
            \ 'javascript.jsx': ['javascript-typescript-stdio'],
            \ 'glsl': ['glslls', '--stdin'],
            \ 'lua': ['lua-lsp'],
            \ 'css': ['css-languageserver', '--stdio'],
            \ 'sass': ['css-languageserver', '--stdio'],
            \ 'less': ['css-languageserver', '--stdio'],
            \ }

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/home/zach/.config/nvim/settings.json'

" let g:LanguageClient_changeThrottle = 0.05

let g:LanguageClient_diagnosticsList = 'Location'

nnoremap <silent> gK :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> gR :call LanguageClient_textDocument_references()<CR>

" set formatexpr=LanguageClient_textDocument_rangeFormatting()

" }}}

" Airline {{{

" Takes colors from normal colorscheme
let g:airline_theme = 'tomorrow'
" let g:airline_theme = 'onedark'

if $TERM =~ ".*linux" || $TERM =~ ".*screen"
    let g:airline_symbols_ascii = 1
    let g:airline_powerline_fonts = 0
else
    let g:airline_symbols_ascii = 0
    let g:airline_powerline_fonts = 1
endif

" Don't use fancy powerline separators
let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = '|'
let g:airline_left_alt_sep = '|'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#show_close_button = 0

let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#c_like_langs =
            \ ['c', 'cpp', 'java', 'javascript', 'php', 'glsl']
" }}}

" Autopairs {{{
" Extra line inside parentheses is not correct style for LISP
autocmd FileType lisp,scheme let g:AutoPairsMapCR = 0
" }}}

" VimTex {{{
let g:vimtex_compiler_enabled = 0
let g:vimtex_fold_enable = 0
let g:vimtex_format_enabled = 1
let g:vimtex_imaps_leader = '<F2>'

let g:tex_conceal = ""

" }}}

" NeoTex {{{
let g:neotex_enabled = 1
let g:neotex_pdflatex_options = "-shell-escape"
" }}}

" vim-skeleton {{{
let g:skeleton_template_dir = "~/.config/nvim/skeleton"
let g:skeleton_replacements = {}
function! g:skeleton_replacements.AUTHOR()
    return "Zach Peltzer"
endfunction
function! g:skeleton_replacements.INCLUDE_GUARD()
    return substitute(toupper(expand('%:t')), '\.', '_', 'g') . '_'
endfunction
" }}}

" ALE {{{
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_echo_cursor = 1
let g:ale_set_balloons = 0

let g:ale_fix_on_save = 1

" let g:ale_completion_enabled = 1

" Increase delays a little
let g:ale_lint_delay = 250
let g:ale_echo_delay = 100

" Allow local (POSIX) C standard
let g:ale_c_clang_options = "-Wall"

let g:ale_linters = {
            \ 'c': ['clang', 'clang-check'],
            \ 'cpp': ['clang', 'clang-check'],
            \ 'javascript': ['jshint'],
            \ }

" }}}

" QF {{{
let g:qf_mapping_ack_style = 1

" Mappings for quick-fix lists
noremap `c :<C-U>cc <C-R>=v:count ? v:count : ''<CR><CR>
nnoremap [c <Plug>qf_qf_previous
nnoremap ]c <Plug>qf_qf_next
nnoremap `C <Plug>qf_qf_toggle

noremap `l :<C-U>ll <C-R>=v:count ? v:count : ''<CR><CR>
nnoremap [l <Plug>qf_loc_previous
nnoremap ]l <Plug>qf_loc_next
nnoremap `L <Plug>qf_loc_toggle
" }}}

" EchoDoc {{{
let g:echodoc#enable_at_startup = 1
" }}}

" local-vimrc {{{
let g:localvimrc_persistent = 1
" }}}

" vim-gutentags {{{
let g:gutentags_ctags_tagfile = ".tags"
" }}}

" vim-unimpaired {{{
vmap =p "_dp
vmap =P "_dP
" TODO Make indent-on-paste default (vim-unimpaired's method doesn't work for
" non-linewise pastes so it will probably need to be changed)
" }}}

" vim-javascript / vim-jsx {{{

let g:javascript_plugin_jsdoc = 1

" }}}

" }}}

