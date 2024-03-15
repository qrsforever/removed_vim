"{{{ errormarker Setup 
nmap <silent> <unique> `<space> :ErrorAtCursor<CR>
" hi ErrorMsg cterm=bold ctermbg=DarkRed gui=bold guibg=DarkRed
" hi WarningMsg cterm=bold ctermbg=LightRed gui=bold guibg=LightRed
let errormarker_errortext = "EE"
let errormarker_warningtext = "WW"
let errormarker_warningtypes = "wW"
let errormarker_errorgroup = "ErrorMsg"
let errormarker_warninggroup = "Todo"
" let &errorformat="%f:%l:%c: %t %n: %m," . &errorformat
" let &errorformat="%f:%l:%c: %t%*[^:]:%m," . &errorformat
"f:file l:line c:column t:warningtypes m:message
let errormarker_erroricon = expand(g:VIM_HOME ."/res/icons/dialog-error.png") 
let errormarker_warningicon = expand(g:VIM_HOME . "res/icons/dialog-warning.png")
"}}}
