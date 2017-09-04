
"[normal, horizontal, vertical, context]
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories =['UltiSnips']
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<nul>"
let g:UltiSnipsJumpBackwardTrigger="<nul>"
let g:UltiSnipsListSnippets="<c-e>"
let g:UltiSnipsUsePythonVersion = 3

let g:ulti_expand_or_jump_res = 0 "default value, just set once
function! Ulti_ExpandOrJump_and_getRes()
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfunction

inoremap <NL> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":IMAP_Jumpfunc('', 0)<CR>
