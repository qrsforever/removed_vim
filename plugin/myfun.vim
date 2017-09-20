function! MyFun_is_special_buffer(bt) "{{{
    let buftype = a:bt != '' ? a:bt : getbufvar('%', '&filetype')
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

command! MyScroll call s:_MyScrollBinder()
function s:_MyScrollBinder() "{{{
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

command! MyBottomCopen  call s:_MyCopen(0)
command! MyTopCopen     call s:_MyCopen(1)
function s:_MyCopen(place) "{{{
    let h = winheight(0) / 3 - 5
    if h < 5
        let h = ''
    endif
    if a:place == 1
        execute "topleft copen" . h
    elseif a:place == 0
        execute "botright copen" . h
    else
        let w = winwidth(0) / 2 - 5
        if w < 5
            execute "vertical copen" . w
        else
            execute "vertical copen"
        endif
    endif
endfunction"}}}

autocmd FileType nerdtree,tagbar,lookupfile set cc=""
command! MyColColor call s:_MyColColor()
function! s:_MyColColor() "{{{
    let cx = &colorcolumn
    let cz = "+1," . col(".")
    if cx != '' && cx == cz
        exec "set cc=\"\""
    else
        exec "set cc=+1," . col(".")
    endif
endfunc "}}}

command! MyMarkColor call s:_MyMarkColor()
function! s:_MyMarkColor() "{{{
    exec "Mark " . expand("<cword>")
endfunc "}}}

command! MyMarksBrowser call s:_MyMarksBrowser()
function! s:_MyMarksBrowser() "{{{
    let buftype = getbufvar('%', '&filetype')
    if 'marksbuffer' == buftype 
        exec "MarksBrowser"
        return
    endif
    if MyFun_is_special_buffer(buftype)
        return
    endif
    exec "MarksBrowser"
endfunction "}}}
