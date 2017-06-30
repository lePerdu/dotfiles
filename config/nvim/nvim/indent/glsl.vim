" Vim indent file
" Language: OpenGL Shading Language (GLSL)

if exists('b:did_indent')
    finish
endif
let b:did_indent = 1

" Indenting is (pretty much) the same as C
setlocal cindent

" Take away indent support for labels
" Make sure option is appended to the end of the list
setlocal cinoptions-=L0
setlocal cinoptions+=L0

let b:undo_indent = 'setl cin<'
