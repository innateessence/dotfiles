if exists("b:current_syntax") | finish | endif

syn keyword fjStatement   PROC ENDPROC BEGIN CALL START CMD CHECK ABORT
syn keyword fjConditional IF ELSE ENDIF
syn keyword fjRepeat      WHILE ENDWHILE
syn keyword fjBuiltin     WAIT WAIT_UNTIL TM NOW TORAD
syn keyword fjType        INT STRING REAL
syn keyword fjOperator    AND OR NOT

syn region  fjString    start=+"+ end=+"+
syn match   fjNumber    "\<\d\+\(\.\d\+\)\?\>"
syn match   fjNumber    "\<0x\x\+\>"
syn match   fjLineCmt   "//.*$"        contains=fjTodo
syn region  fjBlockCmt  start="/\*" end="\*/" contains=fjTodo
syn keyword fjTodo      TODO FIXME NOTE XXX HACK contained

hi def link fjStatement   Statement
hi def link fjConditional Conditional
hi def link fjRepeat      Repeat
hi def link fjBuiltin     Function
hi def link fjType        Type
hi def link fjOperator    Operator
hi def link fjString      String
hi def link fjNumber      Number
hi def link fjLineCmt     Comment
hi def link fjBlockCmt    Comment
hi def link fjTodo        Todo

let b:current_syntax = "flightjas"
