" Vim syntax file
" Language:	JavaScript (ECMAScript 6)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
" tuning parameters:
" unlet javaScript_fold

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


syn keyword javaScriptCommentTodo      TODO FIXME XXX TBD contained
syn match   javaScriptLineComment      "\/\/.*" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syn region  javaScriptComment	       start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo
syn match   javaScriptSpecial	       "\\\d\d\d\|\\."
syn region  javaScriptStringD	       start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=javaScriptSpecial,@htmlPreproc
syn region  javaScriptStringS	       start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=javaScriptSpecial,@htmlPreproc

syn match   javaScriptSpecialCharacter "'\\.'"
syn match   javaScriptNumber	       "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn region  javaScriptRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syn region  javaScriptTemplateLiteral  start="`" skip="\\`" end="`" keepend extend contains=javaScriptTemplateVar
syn region  javaScriptTemplateVar      matchgroup=javaScriptBraces start="\\\@<!\${" end="\\\@<!}" contained contains=TOP,javaScriptComment,javaScriptLineComment

syn keyword javaScriptConditional	if else switch
syn keyword javaScriptRepeat		while for do in of
syn keyword javaScriptBranch		break continue
syn keyword javaScriptOperator		new delete instanceof typeof
syn keyword javaScriptType		Array Boolean Date Function Number Object String RegExp
syn keyword javaScriptStatement		return with
syn keyword javaScriptBoolean		true false
syn keyword javaScriptNull		null undefined
syn keyword javaScriptIdentifier	arguments this super var let const
syn keyword javaScriptLabel		case default
syn keyword javaScriptException		try catch finally throw
syn keyword javaScriptMessage		alert confirm prompt status
syn keyword javaScriptGlobal		self window top parent
syn keyword javaScriptMember		document event location
syn keyword javaScriptDeprecated	escape unescape
syn keyword javaScriptImport            import export as from default
syn keyword javaScriptClass             class extends static
"syn keyword javaScriptReserved		abstract boolean byte char debugger double enum final float goto implements int interface long native package private protected public short synchronized throws transient volatile

" Don't highlight stuff when accessed as properties.
" Do highlight stuff after the spread operator (...).
syn match  javaScriptProperty		"\v(.\.)@<!\.\k+"

if exists("javaScript_fold")
    syn match	javaScriptFunction	"\<function\>"
    syn region	javaScriptFunctionFold	start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match javaScriptSync	grouphere javaScriptFunctionFold "\<function\>"
    syn sync match javaScriptSync	grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword javaScriptFunction	function get set constructor
    syn match   javaScriptArrow		"=>"
    syn match	javaScriptBraces	   "[{}\[\]]"
    syn match	javaScriptParens	   "[()]"
endif

syn sync fromstart
syn sync maxlines=100

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
  HiLink javaScriptComment		Comment
  HiLink javaScriptLineComment		Comment
  HiLink javaScriptCommentTodo		Todo
  HiLink javaScriptSpecial		Special
  HiLink javaScriptStringS		String
  HiLink javaScriptStringD		String
  HiLink javaScriptCharacter		Character
  HiLink javaScriptSpecialCharacter	javaScriptSpecial
  HiLink javaScriptNumber		javaScriptValue
  HiLink javaScriptConditional		Conditional
  HiLink javaScriptRepeat		Repeat
  HiLink javaScriptBranch		Conditional
  HiLink javaScriptOperator		Operator
  HiLink javaScriptType			Type
  HiLink javaScriptStatement		Statement
  HiLink javaScriptFunction		Function
  HiLink javaScriptArrow		Function
  HiLink javaScriptBraces		Function
  HiLink javaScriptError		Error
  HiLink javaScrParenError		javaScriptError
  HiLink javaScriptNull			Keyword
  HiLink javaScriptBoolean		Boolean
  HiLink javaScriptRegexpString		String
  HiLink javaScriptTemplateLiteral      String

  HiLink javaScriptIdentifier		Identifier
  HiLink javaScriptLabel		Label
  HiLink javaScriptException		Exception
  HiLink javaScriptMessage		Keyword
  HiLink javaScriptGlobal		Keyword
  HiLink javaScriptMember		Keyword
  HiLink javaScriptImport               Keyword
  HiLink javaScriptClass		Keyword
  HiLink javaScriptDeprecated		Exception
  HiLink javaScriptDebug		Debug
  HiLink javaScriptConstant		Label

  delcommand HiLink
endif

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8
