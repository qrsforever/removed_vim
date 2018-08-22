"Setup{{{
let g:DoxygenToolkit_briefTag_pre="@Brief  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
" let g:DoxygenToolkit_briefTag_post = " "
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_paramTag_post=": "
" let g:DoxygenToolkit_blockHeader=""
" let g:DoxygenToolkit_blockFooter=""
let g:DoxygenToolkit_authorName="QRS"
let g:DoxygenToolkit_licenseTag="\<enter>Copyright (C) 2018 QRS, all rights reserved."
let g:DoxygenToolkit_commentType = "C++"

function! <SID>_DoxygenCommentFunc()
    exec "Dox"
    exec "delmarks d"
endfunction

command! -nargs=0 XDoxy :call <SID>_DoxygenCommentFunc()
"}}}
