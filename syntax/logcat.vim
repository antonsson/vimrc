" Vim syntax file

if exists("b:current_syntax")
    finish
endif

"Define colors
syn match simpleNumbers '[^a-zA-Z\=\:\[\(\/]\d\+'
syn match dateTimeStamp '^\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\.\d\{3}\s\+\d\+\s\+\d\+'
syn match errorTag   ' [EF] [-a-zA-Z0-9_]\+'
syn match warningTag ' [W] [-a-zA-Z0-9_]\+'
syn match normalTag  ' [DIV] [-a-zA-Z0-9_]\+'

" Add highlighted tags here
syn match highPrioTag 'ANTON' containedin=tagString contained

hi def link simpleNumbers Number
hi def link dateTimeStamp Comment
hi def link highPrioTag Statement
hi def link errorTag Keyword
hi def link warningTag Define
hi def link normalTag PreProc

"hi def link javaClassDecl PreProc

let b:current_syntax = "logcat"
