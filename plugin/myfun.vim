"========Scroll
command! MyScroll call s:MyScrollBinder()

function s:MyScrollBinder() 
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
endfunction

command! MyCopen call s:_MyCopen()
function s:_MyCopen()
    let h = winheight(0) / 3 - 5
    execute "topleft copen" . h
    " let w = winwidth(0) / 2 - 5
    " execute "vertical copen" . w
endfunction
