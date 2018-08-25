" Vim syntax file
" Language: JavaScript (ECMAScript 6)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet javaScript_fold

finish

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("javaScript_fold")
  unlet javaScript_fold
endif

syn iskeyword @,48-57,_,192-255,$
set iskeyword+=$

" For JSDoc-style annotations
syn match javaScriptCommentTag "@\w\+" contained
syn region javaScriptCommentInlineTag matchgroup=javaScriptCommentTag start="[^\\]\zs@{\k\+" skip="\\}" end="}" contained

syn keyword javaScriptCommentTodo       TODO FIXME XXX TBD contained
syn match   javaScriptLineComment       "\/\/.*" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptCommentSkip       "^[ \t]*\*\($\|[ \t]\+\)"
syn region  javaScriptComment           start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo,javaScriptCommentTag,javaScriptCommentInlineTag
syn match   javaScriptSpecial           "\\\d\d\d\|\\."
syn region  javaScriptStringD           start=+"+  skip=+\\\\\|\\"+  end=+"\|[^\\]$+    contains=javaScriptSpecial,@htmlPreproc
syn region  javaScriptStringS           start=+'+  skip=+\\\\\|\\'+  end=+'\|[^\\]$+    contains=javaScriptSpecial,@htmlPreproc

syn match   javaScriptSpecialCharacter  "'\\.'"
syn match   javaScriptNumber            "\<\d\+\|0[xX]\x\+\|0[bB][01]\+\>"
syn match   javaScriptNumber            "\.\d\+\([eE][-+]\?\d\+\)\?\>"
syn match   javaScriptNumber            "\<\d\+\([eE][-+]\?\d\+\)\?\>"
syn match   javaScriptNumber            "\<\d\+\.\d*\([eE][-+]\?\d\+\)\?\>"
syn region  javaScriptRegexpString      start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syn region  javaScriptTemplateLiteral   start="`" skip="\\`" end="`" keepend extend contains=javaScriptTemplateVar
syn region  javaScriptTemplateVar       matchgroup=javaScriptSpecial start="\\\@<!\${" end="\\\@<!}" contained contains=TOP,javaScriptComment,javaScriptLineComment

syn keyword javaScriptConditional       if else switch
syn keyword javaScriptRepeat            while for do in of
syn keyword javaScriptBranch            break continue
syn keyword javaScriptOperator          delete instanceof typeof

syn keyword javaScriptStatement         return with yield
syn keyword javaScriptAsync             async await
syn keyword javaScriptBoolean           true false
syn keyword javaScriptNull              null undefined
syn keyword javaScriptIdentifier        arguments this super
syn keyword javaScriptVariable          var let const
syn keyword javaScriptLabel             case default
syn keyword javaScriptException         try catch finally throw debugger
syn keyword javaScriptMessage           confirm prompt
syn keyword javaScriptGlobal            self window
syn keyword javaScriptMember            document
syn keyword javaScriptDeprecated        escape unescape
syn keyword javaScriptExport            export default
syn keyword javaScriptImport            import as from contained
syn keyword javaScriptClass             class extends
"syn keyword javaScriptReserved        abstract boolean byte char
"double enum final float goto implements int interface long native package
"private protected public short synchronized throws transient volatile

syn keyword javaScriptType Array TypedArray ArrayBuffer Float32Array
syn keyword javaScriptType Float64Array Int16Array Int32Array Int8Array
syn keyword javaScriptType Uint16Array Uint32Array Uint8Array
syn keyword javaScriptType Uint8ClampedArray AsyncFunction Atomics Boolean
syn keyword javaScriptType DataView Date Error EvalError
syn keyword javaScriptType Function Generator GeneratorFunction Infinity
syn keyword javaScriptType InternalError Intl Iterator JSON
syn keyword javaScriptType Map Math NaN Number Object ParallelArray Promise
syn keyword javaScriptType Proxy RangeError ReferenceError
syn keyword javaScriptType Reflect RegExp SIMD SharedArrayBuffer Set
syn keyword javaScriptType StopIteration String Symbol
syn keyword javaScriptType SyntaxError TypeError URIError WeakMap WeakSet
syn keyword javaScriptType WebAssembly WebGLRenderingContext
syn keyword javaScriptType WebGL2RenderingContext

syn region javaScriptImportRegion start="\<import\>" end=";" end="$"
            \ contains=ALL,@Spell

syn match javaScriptAccessor "\<\(get\|set\)\ze\_s\+\%(\[\_.\{-}\]\|\k\+\)"

" These are commonly used as variable names
"syn keyword javaScriptTooMuchHighlighting alert status top parent event location

" Don't highlight anything when accessed as properties (so that keywords can be
" used as function/property names, even though this is bad practice).
" Do highlight stuff after the spread operator (...).
syn match  javaScriptProperty        "\v(\.\.)@<!\.\_s*\k+"
            \ contains=javaScriptFuncCall,javaScriptNumber

syn match javaScriptFuncCall "\k\+\ze\_s*("
syn match javascriptConstructor "\k\+\ze\_s*(" contained
syn match javaScriptNew "\<new\>" skipwhite nextgroup=javaScriptConstructor,javaScriptType

syn keyword javaScriptFunction  function constructor
syn keyword javaScriptStorateClass static
syn match   javaScriptArrow     "=>"
syn match   javaScriptBraces    "[{}\[\]]"
syn match   javaScriptParens    "[()]"

if exists("javaScript_fold")
    syn region javaScriptFunctionFold
                \ start="\<function\>.*[^};]$" end="^\z1}.*$"
                \ transparent fold keepend

    syn sync match javaScriptSync grouphere javaScriptFunctionFold "\<function\>"
    syn sync match javaScriptSync grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
endif

syn sync fromstart

if main_syntax == "javascript"
    syn sync ccomment javaScriptComment
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
    if version < 508
        let did_javascript_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink javaScriptComment          Comment
    HiLink javaScriptLineComment      Comment
    HiLink javaScriptCommentTodo      Todo
    HiLink javaScriptCommentTag       PreProc
    HiLink javaScriptSpecial          Special
    HiLink javaScriptStringS          String
    HiLink javaScriptStringD          String
    HiLink javaScriptCharacter        Character
    HiLink javaScriptSpecialCharacter javaScriptSpecial
    HiLink javaScriptNumber           Number
    HiLink javaScriptConditional      Conditional
    HiLink javaScriptRepeat           Repeat
    HiLink javaScriptBranch           Conditional
    HiLink javaScriptOperator         Operator
    HiLink javaScriptNew              Operator
    HiLink javaScriptType             Constant
    HiLink javaScriptStatement        Statement
    HiLink javaScriptAsync            Statement
    HiLink javaScriptFunction         Operator
    HiLink javaScriptAccessor         javaScriptFunction
    HiLink javaScriptArrow            javaScriptFunction
    HiLink javaScriptFuncCall         Function
    HiLink javascriptConstructor      Type
    HiLink javaScriptError            Error
    HiLink javaScrParenError          javaScriptError
    HiLink javaScriptBoolean          Boolean
    HiLink javaScriptNull             Boolean
    HiLink javaScriptRegexpString     String
    HiLink javaScriptTemplateLiteral  String
    HiLink javaScriptVariable         Keyword
    HiLink javaScriptStorateClass     StorageClass

    HiLink javaScriptIdentifier       Identifier
    HiLink javaScriptLabel            Label
    HiLink javaScriptException        Exception
    HiLink javaScriptMessage          Keyword
    HiLink javaScriptGlobal           Keyword
    HiLink javaScriptMember           Keyword
    HiLink javaScriptImport           Include
    HiLink javaScriptExport           Include
    HiLink javaScriptClass            Keyword
    HiLink javaScriptDeprecated       Error
    HiLink javaScriptDebug            Debug
    HiLink javaScriptConstant         Constant

    " HiLink javaScriptBraces           Function

    delcommand HiLink
endif

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
    unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

