" Maintainer: Anmol Sethi <anmol@aubble.com>
" (Edited to support mdocml)

let s:man_find_arg = "-w"

" TODO(nhooyr) Completion may work on SunOS; I'm not sure if `man -l` displays
" the list of searched directories.
try
  if !has('win32') && $OSTYPE !~? 'cygwin\|linux' && system('uname -s') =~? 'SunOS' && system('uname -r') =~# '^5'
    let s:man_find_arg = '-l'
  endif
catch /E145:/
  " Ignore the error in restricted mode
endtry

function! man#open_page(count, count1, mods, ...) abort
  " v:count defaults to 0 which is a valid section, and v:count1 defaults to
  " 1, also a valid section. If they are equal, count explicitly set.
  let sect = a:count ==# a:count1 ? string(a:count) : ''

  if a:0 > 2
    call s:error('too many arguments')
    return
  elseif a:0 == 0
    let ref = &filetype ==# 'man' ? expand('<cWORD>') : expand('<cword>')
    if empty(ref)
      call s:error('no identifier under cursor')
      return
    endif
  elseif a:0 ==# 1
    let ref = a:1 . (sect ? '(' . sect . ')' : '')
  else
    " Combine the name and sect into a manpage reference so that all
    " verification/extraction can be kept in a single function.
    " If a:2 is a reference as well, that is fine because it is the only
    " reference that will match.
    let ref = a:2 . '(' . (sect ? sect : a:1) . ')'
  endif

  try
    let [sect, name] = man#get_name_and_sect_ref(ref)
  catch
    call s:error(v:exception)
    return
  endtry

  call s:push_tag()
  let bufname = 'man://'.name.(empty(sect)?'':'('.sect.')')

  try
    set eventignore+=BufReadCmd
    if a:mods !~# 'tab' && s:find_man()
      execute 'silent edit' fnameescape(bufname)
    else
      execute 'silent' a:mods 'split' fnameescape(bufname)
    endif
  finally
    set eventignore-=BufReadCmd
  endtry

  try
    let page = s:get_page(sect, name)
  catch
    if a:mods =~# 'tab' || !s:find_man()
      " a new window was opened
      close
    endif
    call s:error(v:exception)
    return
  endtry

  let b:man_sect = sect
  call s:put_page(page)
endfunction

function! man#read_page(ref) abort
  try
    let [sect, name] = man#get_name_and_sect_ref(a:ref)
    let page = s:get_page(sect, name)
  catch
    call s:error(v:exception)
    return
  endtry
  let b:man_sect = sect
  call s:put_page(page)
endfunction

" Handler for s:system() function.
function! s:system_handler(jobid, data, event) dict abort
  if a:event == 'stdout'
    let self.stdout .= join(a:data, "\n")
  elseif a:event == 'stderr'
    let self.stderr .= join(a:data, "\n")
  else
    let self.exit_code = a:data
  endif
endfunction

" Run a system command and timeout after 30 seconds.
function! s:system(cmd, ...) abort
  let opts = {
        \ 'stdout': '',
        \ 'stderr': '',
        \ 'exit_code': 0,
        \ 'on_stdout': function('s:system_handler'),
        \ 'on_stderr': function('s:system_handler'),
        \ 'on_exit': function('s:system_handler'),
        \ }
  let jobid = jobstart(a:cmd, opts)

  if jobid < 1
    throw printf('command error %d: %s', jobid, join(a:cmd))
  endif

  let res = jobwait([jobid], 30000)
  if res[0] == -1
    try
      call jobstop(jobid)
      throw printf('command timed out: %s', join(a:cmd))
    catch /^Vim\%((\a\+)\)\=:E900/
    endtry
  elseif res[0] == -2
    throw printf('command interrupted: %s', join(a:cmd))
  endif
  if opts.exit_code != 0
    throw printf("command error (%d) %s: %s", jobid, join(a:cmd), substitute(opts.stderr, '\_s\+$', '', &gdefault ? '' : 'g'))
  endif

  return opts.stdout
endfunction

function! s:get_page(sect, page) abort
  " Respect $MANWIDTH or default to window width.
  let manwidth = empty($MANWIDTH) ? winwidth(0) : $MANWIDTH
  " Force MANPAGER=cat to ensure Vim is not recursively invoked (by man-db).
  " http://comments.gmane.org/gmane.editors.vim.devel/29085
  return s:system(['env', 'MANPAGER=cat', 'MANWIDTH='.manwidth, 'man', a:sect, a:page])
endfunction

function! s:put_page(page) abort
  setlocal modifiable
  setlocal noreadonly
  silent keepjumps %delete _
  silent put =a:page
  " Remove all backspaced/escape characters.
  execute 'silent keeppatterns keepjumps %substitute,.\b\|\e\[\d\+m,,e'.(&gdefault?'':'g')
  while getline(1) =~# '^\s*$'
    silent keepjumps 1delete _
  endwhile
  setlocal filetype=man
endfunction

function! man#show_toc() abort
  let bufname = bufname('%')
  let info = getloclist(0, {'winid': 1})
  if !empty(info) && getwinvar(info.winid, 'qf_toc') ==# bufname
    lopen
    return
  endif

  let toc = []
  let lnum = 2
  let last_line = line('$') - 1
  while lnum && lnum < last_line
    let text = getline(lnum)
    if text =~# '^\%( \{3\}\)\=\S.*$'
      call add(toc, {'bufnr': bufnr('%'), 'lnum': lnum, 'text': text})
    endif
    let lnum = nextnonblank(lnum + 1)
  endwhile

  call setloclist(0, toc, ' ')
  call setloclist(0, [], 'a', {'title': 'Man TOC'})
  lopen
  let w:qf_toc = bufname
endfunction

function! man#get_name_and_sect_ref(ref) abort
  if a:ref[0] == '-' " Try 'Man: -pandoc' with this disabled.
    throw 'manpage cannot start with ''-'''
  endif
  let [ref, name, _, sect; _] = matchlist(a:ref, '\([^()]\+\)\((\(.*\))\)\?')
  if empty(sect)
    let sect = get(b:, 'man_default_sects', '')
  endif

  if !empty(sect)
    let found_sect = 0
    for s in split(sect, ',')
      if s:verify_exists(s, name)
        let found_sect = s
        break
      endif
    endfor

    if found_sect
      return [found_sect, name]
    endif
  else
    if s:verify_exists(sect, name)
      return [sect, name]
    endif
  endif

  throw "no matching manpage found"
endfunction

function! s:verify_exists(sect, name) abort
  if empty(a:sect)
    call s:system(['man', s:man_find_arg, a:name])
  else
    call s:system(['man', s:man_find_arg, '-s', a:sect, a:name])
  endif

  " s:system() throws an exception if the command fails, so this will not be
  " reached in that case
  return 1
endfunction

let s:tag_stack = []

function! s:push_tag() abort
  let s:tag_stack += [{
        \ 'buf':  bufnr('%'),
        \ 'lnum': line('.'),
        \ 'col':  col('.'),
        \ }]
endfunction

function! man#pop_tag() abort
  if !empty(s:tag_stack)
    let tag = remove(s:tag_stack, -1)
    execute 'silent' tag['buf'].'buffer'
    call cursor(tag['lnum'], tag['col'])
  endif
endfunction

" extracts the name and sect out of 'path/name.sect'
function! s:extract_sect_and_name_path(path) abort
  let tail = fnamemodify(a:path, ':t')
  if a:path =~# '\.\%([glx]z\|bz2\|lzma\|Z\)$' " valid extensions
    let tail = fnamemodify(tail, ':r')
  endif
  let sect = matchstr(tail, '\.\zs[^.]\+$')
  let name = matchstr(tail, '^.\+\ze\.')
  return [sect, name]
endfunction

function! s:find_man() abort
  if &filetype ==# 'man'
    return 1
  elseif winnr('$') ==# 1
    return 0
  endif
  let thiswin = winnr()
  while 1
    wincmd w
    if &filetype ==# 'man'
      return 1
    elseif thiswin ==# winnr()
      return 0
    endif
  endwhile
endfunction

function! s:error(msg) abort
  redraw
  echohl ErrorMsg
  echon 'man.vim: ' a:msg
  echohl None
endfunction

" see man#extract_sect_and_name_ref on why tolower(sect)
function! man#complete(arg_lead, cmd_line, cursor_pos) abort
  let args = split(a:cmd_line)
  let l = len(args)
  if l > 3
    return
  elseif l ==# 1
    let name = ''
    let sect = ''
  elseif a:arg_lead =~# '^[^()]\+([^()]*$'
    " cursor (|) is at ':Man printf(|' or ':Man 1 printf(|'
    " The later is is allowed because of ':Man pri<TAB>'.
    " It will offer 'priclass.d(1m)' even though section is specified as 1.
    let tmp = split(a:arg_lead, '(')
    let name = tmp[0]
    let sect = tolower(get(tmp, 1, ''))
    return s:complete(sect, '', name)
  elseif args[1] !~# '^[^()]\+$'
    " cursor (|) is at ':Man 3() |' or ':Man (3|' or ':Man 3() pri|'
    " or ':Man 3() pri |'
    return
  elseif l ==# 2
    if empty(a:arg_lead)
      " cursor (|) is at ':Man 1 |'
      let name = ''
      let sect = tolower(args[1])
    else
      " cursor (|) is at ':Man pri|'
      if a:arg_lead =~# '\/'
        " if the name is a path, complete files
        " TODO(nhooyr) why does this complete the last one automatically
        return glob(a:arg_lead.'*', 0, 1)
      endif
      let name = a:arg_lead
      let sect = ''
    endif
  elseif a:arg_lead !~# '^[^()]\+$'
    " cursor (|) is at ':Man 3 printf |' or ':Man 3 (pr)i|'
    return
  else
    " cursor (|) is at ':Man 3 pri|'
    let name = a:arg_lead
    let sect = tolower(args[1])
  endif
  return s:complete(sect, sect, name)
endfunction

function! s:complete(sect, psect, name) abort
  try
    let mandirs = join(split(s:system(['man', s:man_find_arg]), ':\|\n'), ',')
  catch
    call s:error(v:exception)
    return
  endtry
  let pages = globpath(mandirs,'man?/'.a:name.'*.'.a:sect.'*', 0, 1)
  " We remove duplicates in case the same manpage in different languages was found.
  return uniq(sort(map(pages, 's:format_candidate(v:val, a:psect)'), 'i'))
endfunction

function! s:format_candidate(path, psect) abort
  if a:path =~# '\.\%(pdf\|in\)$' " invalid extensions
    return
  endif
  let [sect, name] = s:extract_sect_and_name_path(a:path)
  if sect ==# a:psect
    return name
  elseif sect =~# a:psect.'.\+$'
    " We include the section if the user provided section is a prefix
    " of the actual section.
    return name.'('.sect.')'
  endif
endfunction

function! man#init_pager() abort
  " Remove all backspaced/escape characters.
  execute 'silent keeppatterns keepjumps %substitute,.\b\|\e\[\d\+m,,e'.(&gdefault?'':'g')
  if getline(1) =~# '^\s*$'
    silent keepjumps 1delete _
  else
    keepjumps 1
  endif
  " This is not perfect. See `man glDrawArraysInstanced`. Since the title is
  " all caps it is impossible to tell what the original capitilization was.
  let ref = substitute(matchstr(getline(1), '^[^)]\+)'), ' ', '_', 'g')
  try
    let b:man_sect = man#get_name_and_sect_ref(ref)[1]
  catch
    let b:man_sect = ''
  endtry
  execute 'silent file man://'.fnameescape(ref)
endfunction

" vim: ts=2:sts=2:sw=2
