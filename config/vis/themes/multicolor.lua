-- A vis version of the multicolor theme at
-- https://github.com/lePerdu/multicolor.vim

local lexers = vis.lexers

lexers.STYLE_DEFAULT = 'fore:#aaaaaa,back:#050505'
lexers.STYLE_NOTHING = ''
lexers.STYLE_CLASS = 'fore:#7788af'
lexers.STYLE_COMMENT = 'fore:#606060,italics'
lexers.STYLE_CONSTANT = 'fore:#87af5f,bold'
lexers.STYLE_DEFINITION = 'fore:#822777'
lexers.STYLE_ERROR = 'fore:#e33a6e,bold'
lexers.STYLE_FUNCTION = 'fore:#3ca4d8'
lexers.STYLE_KEYWORD = 'fore:#e0da37'
lexers.STYLE_LABEL = 'fore:#e0da37'
lexers.STYLE_NUMBER = 'fore:#f1af5f'
lexers.STYLE_OPERATOR = ''
lexers.STYLE_REGEX = 'fore:#2c5123'
lexers.STYLE_STRING = 'fore:#2c5123'
lexers.STYLE_PREPROCESSOR = 'fore:#de5e1e'
lexers.STYLE_TAG = 'fore:#d7afaf,bold' -- TODO use?
lexers.STYLE_TYPE = 'fore:#7788af'
lexers.STYLE_VARIABLE = 'fore:#e33a6e' -- TODO vs IDENTIFIER?
lexers.STYLE_WHITESPACE = ''
lexers.STYLE_EMBEDDED = ''
lexers.STYLE_IDENTIFIER = ''

lexers.STYLE_LINENUMBER = 'fore:#4b5263'
lexers.STYLE_LINENUMBER_CURSOR = 'fore:#4b5263' -- TODO Inherits LINENUMBER?
lexers.STYLE_CURSOR = 'fore:#050505,back:#ff8c00'
lexers.STYLE_CURSOR_PRIMARY = 'fore:#1c1c1c,back:#87afaf,bold' -- TODO Use?
lexers.STYLE_CURSOR_LINE = 'back:#121212'
lexers.STYLE_COLOR_COLUMN = 'back:#121212'
lexers.STYLE_SELECTION = 'back:#1a1e20'
lexers.STYLE_STATUS = 'fore:606060,back:#121212'
lexers.STYLE_STATUS_FOCUSED = 'fore:#aaaaaa,back:#121212,bold'
lexers.STYLE_SEPARATOR = ''
lexers.STYLE_INFO = ''
lexers.STYLE_EOF = 'fore:#585858'

