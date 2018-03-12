"Setup{{{
let g:DoxygenToolkit_briefTag_pre="@Brief  "
" let g:DoxygenToolkit_briefTag_post = " "
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_paramTag_pre="@Param [in] "
let g:DoxygenToolkit_paramTag_post=": "
let g:DoxygenToolkit_returnTag="@Returns   "
" let g:DoxygenToolkit_blockHeader=""
" let g:DoxygenToolkit_blockFooter=""
let g:DoxygenToolkit_authorName="Michal Dong"
let g:DoxygenToolkit_licenseTag="\<enter>Copyright (C) 2018 LeEco, all rights reserved."

function! <SID>_DoxygenCommentFunc()
    exec "Dox"
    exec "delmarks d"
endfunction

command! -nargs=0 XD :call <SID>_DoxygenCommentFunc()
"}}}
