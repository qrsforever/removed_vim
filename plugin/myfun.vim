"========Scroll
command! MyScroll call s:MyScrollBinder()
function s:MyScrollBinder() "{{{
    echomsg " Ver(1) Hor(2) Cancel(0) "
    let select = str2nr(input("Select: ", " " ), 10)
    if select == 1
        set scrollbind
        set scrollopt=ver
    elseif select == 2
        set scrollbind
        set scrollopt=hor
    else
        set noscrollbind
    endif
endfunction"}}}

command! MyCopen call s:_MyCopen()
function s:_MyCopen()"{{{
    let h = winheight(0) / 3 - 5
    execute "topleft copen" . h
    " let w = winwidth(0) / 2 - 5
    " execute "vertical copen" . w
endfunction"}}}

function! MyFun_is_special_buffer(bt) "{{{
    let buftype = a:bt " getbufvar('%', '&filetype')
    let buffers = ['nerdtree', 'tagbar', 'qf', 'unite', 'lookupfile', 'bufexplorer', 'marksbuffer', 'vimshell']
    let ret = 0
    for name in buffers
        if name ==# buftype
            let ret = 1
            break
        endif
    endfor
    unlet buffers
    return ret
endfunc"}}}

command!  MyColColor call s:_MyColColor()

function! s:_MyColColor() "{{{
    let cc = &colorcolumn
    if cc != ''
        exec "set cc=\"\""
    else
        exec "set cc=+1," . col(".")
    endif
endfunc "}}}
