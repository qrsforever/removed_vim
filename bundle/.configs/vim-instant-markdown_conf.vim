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

function! <SID>_InstantHexoblogPreview(flag)
    if a:flag == 0
        exec "w!"
        call system("0hexo-go " . expand('%:p') . " 0 &>/dev/null &")
    elseif a:flag == 1
        call system("0hexo-go " . expand('%:p') . " 1 &>/dev/null &")
    elseif a:flag == 2
        call system("0hexo-go " . expand('%:p') . " 2 &>/dev/null &")
    endif

endfunction

command! -nargs=0 XMark  :silent! call <SID>_InstantMarkdownPreview()
command! -nargs=0 XHexo  :silent! call <SID>_InstantHexoblogPreview(0)
command! -nargs=0 XHexo2 :silent! call <SID>_InstantHexoblogPreview(1)

autocmd VimLeavePre * call <SID>_InstantHexoblogPreview(2)

"}}}
