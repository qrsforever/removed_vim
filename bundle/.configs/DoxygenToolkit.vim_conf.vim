"Setup{{{
let g:DoxygenToolkit_briefTag_pre = "@brief"
let g:DoxygenToolkit_briefTag_post = " :"
let g:DoxygenToolkit_paramTag_pre = "@param"
let g:DoxygenToolkit_paramTag_post = " :"
let g:DoxygenToolkit_returnTag = "@returns "
let g:DoxygenToolkit_throwTag_pre = "@exception "
let g:DoxygenToolkit_fileTag = "@file "
let g:DoxygenToolkit_dateTag = "@date "
let g:DoxygenToolkit_briefTag_funcName = "yes"
let g:DoxygenToolkit_blockHeader = "-----------------------------"
let g:DoxygenToolkit_blockFooter = "-----------------------------"
let g:DoxygenToolkit_authorName = "QRS"
let g:DoxygenToolkit_licenseTag = "\<enter>Copyright (C) QRS, all rights reserved."
let g:DoxygenToolkit_commentType = "C++"

function! <SID>_DoxygenCommentFunc()
    exec "Dox"
    exec "delmarks d"
endfunction
"}}}

command! -nargs=0 XDoxy :call <SID>_DoxygenCommentFunc()
