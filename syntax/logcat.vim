" Vim syntax file

if exists("b:current_syntax")
    finish
endif

"Define colors
syn match simpleNumbers '[^a-zA-Z\=\:\[\(\/]\d\+'
syn match dateTimeStamp '^\d\{2}-\d\{2} \d\{2}:\d\{2}:\d\{2}\.\d\{3}\s\+\d\+\s\+\d\+'
syn match tagString ' [DEFIVW] [-a-zA-Z0-9_]\+'
syn match tagString '^[DEFIVW]/[-a-zA-Z0-9_]\+'
syn match logLevel ' [DEFIVW] ' containedin=tagString contained
syn match logLevel '^[DEFIVW]' containedin=tagString contained

" Add unimportant tags here
syn match lowPrioTag 'ActivityManager.*$' containedin=tagString contained

" Add highlighted tags here
syn match highPrioTag 'ANTON' containedin=tagString contained

" Highlight errors
syn match errorOutput 'java\.\lang\.RuntimeException'

hi def link simpleNumbers Number
hi def link dateTimeStamp Comment
hi def link tagString PreProc
hi def link logLevel PreProc
hi def link errorOutput Exception
hi def link lowPrioTag Comment
hi def link highPrioTag Statement

"hi def link javaClassDecl PreProc

let b:current_syntax = "logcat"
