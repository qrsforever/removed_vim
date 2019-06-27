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
let g:priv_draw_spacer  = ',d>'
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

" apt install boxes

"    ________________________
"   /\                       \
"   \_|                       |
"     |                       |
"     |                       |
"     |   ____________________|_
"      \_/_____________________/
"
vmap ,dd !boxes -d dog<CR>
vmap ,df !boxes -d spring<CR>
vmap ,dg !boxes -d cat<CR>
vmap ,dh !boxes -d ian_jones<CR>
vmap ,dj !boxes -d santa<CR>
vmap ,dk !boxes -d capgirl<CR>

vmap ,dz !boxes -d mouse<CR>
vmap ,dx !boxes -d peek<CR>
vmap ,dv !boxes -d parchment<CR>
vmap ,dn !boxes -d boy<CR>
vmap ,dm !boxes -d girl<CR>
