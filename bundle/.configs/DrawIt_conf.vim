"start/stop
":DrawIt[!]

" 与shift + ^冲突
" map ^V... <home>
  
nmap <Esc>[161q	<s-up>

"----> "ay 
"----> ,ra

" vmap <unique> <silent> <F12>        :<c-u>call <SID>_Yank2Register()<CR>
vmap <unique> <silent> <F12>        :<c-u>call My_Yank2Register('v')<CR>
function! My_Yank2Register(m) "{{{
    echomsg "m-->" a:m
    let start = virtcol("'<") 
    let end = virtcol("'>")
    " 当Drawit功能开启后, 点击leftmouse, 总是先进入virtual模式
    if start == end
        exec 'norm! \<esc>'
        return
    endif
    exec 'norm! gv"ay'
endfunction"}}}
