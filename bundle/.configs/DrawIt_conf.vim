"{{{ Setup
"start/stop
":DrawIt[!]

" 与shift + ^冲突
" map ^V... <home>
  
nmap <Esc>[161q	<s-up>

"----> "ay 
"----> ,ra

let g:priv_draw_arrow   = ',da'
let g:priv_draw_box     = ',db'
let g:priv_draw_canvas  = ',dc'
let g:priv_draw_line    = ',dl'
let g:priv_draw_spacer  = ',ds'
let g:priv_draw_ellipse = ',de'

function! MyYank2Reg(mode) 
    let start = virtcol("'<") 
    let end = virtcol("'>")
    " 当Drawit功能开启后, 点击leftmouse, 总是先进入virtual模式
    if start == end
        exec 'norm! \<esc>'
        return
    endif
    exec 'norm! gv"ay'
endfunction 
"}}}
