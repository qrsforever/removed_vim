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

command! -nargs=0 XM :call <SID>_InstantMarkdownPreview()
"}}}
