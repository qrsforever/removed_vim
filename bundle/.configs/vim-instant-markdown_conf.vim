" Setup {{{
" npm -g install instant-markdown-d
" See $VIM_HOME/extern/
"
let g:instant_markdown_autostart = 0
let g:instant_markdown_slow = 1

function! <SID>_InstantMarkdownPreview()
    call system("curl -s -X DELETE http://localhost:8090/ &>/dev/null &")
    exec "silent! InstantMarkdownPreview"
endfunction

function! <SID>_InstantHexoblogPreview(cleanflag)
    let flag = a:cleanflag
    if flag == ''
        call system("hexo-go " . expand('%:p') . " &>/dev/null &")
    else
        call system("hexo-go clean &>/dev/null &")
    endif
endfunction

command! -nargs=0 XMark :call <SID>_InstantMarkdownPreview()
command! -nargs=? XHexo :call <SID>_InstantHexoblogPreview(<q-args>)
"}}}
