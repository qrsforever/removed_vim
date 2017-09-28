
"[normal, horizontal, vertical, context]
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories =['UltiSnips']
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsUsePythonVersion = 3

" " Set <space> as primary trigger
" inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>
" 
" " Expand snippet or return
" let g:ulti_expand_res = 1
" function! Ulti_ExpandOrEnter()
"     call UltiSnips#ExpandSnippet()
"     if g:ulti_expand_res
"         return ''
"     else
"         return "\<return>"
" endfunction
" 
" function! g:UltiSnips_Complete()
"     call UltiSnips#ExpandSnippet()
"     if g:ulti_expand_res == 0
"         if pumvisible()
"             return "\<C-n>"
"         else
"             call UltiSnips#JumpForwards()
"             if g:ulti_jump_forwards_res == 0
"                return "\<TAB>"
"             endif
"         endif
"     endif
"     return ""
" endfunction
" 
" au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
