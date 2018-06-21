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
endfunc "}}}

"{{{ MyScroll
command! MyScroll call s:_MyScrollBinder()
function s:_MyScrollBinder()
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
endfunction "}}}

 "{{{ MyCLopen
command! MyBottomCopen  call s:_MyCLopen('cwindow', 0)
command! MyTopCopen     call s:_MyCLopen('cwindow', 1)
command! MyBelowCopen   call s:_MyCLopen('cwindow', 2)
command! MyAboveCopen   call s:_MyCLopen('cwindow', 3)
command! MyBottomLopen  call s:_MyCLopen('lwindow', 0)
command! MyTopLopen     call s:_MyCLopen('lwindow', 1)
command! MyBelowLopen   call s:_MyCLopen('lwindow', 2)
command! MyAboveLopen   call s:_MyCLopen('lwindow', 3)
function s:_MyCLopen(cmd, place)
    let h = winheight(0) / 2
    if h < 5
        let h = ''
    endif
    if a:place == 0
        execute "botright " . a:cmd . " " . h
    elseif a:place == 1
        execute "topleft " . a:cmd . " " . h
    elseif a:place == 2
        execute "belowright " . a:cmd . " " . h
    elseif a:place == 3
        execute "aboveleft " . a:cmd . " " . h
    else
        let w = winwidth(0) / 2 - 5
        if w < 5
            execute "vertical " . a:cmd . " ". w
        else
            execute "vertical " . a:cmd
        endif
    endif
endfunction
"}}}

"{{{ MyColColor
autocmd FileType nerdtree,tagbar,lookupfile set cc=""
command! MyColColor call s:_MyColColor()
function! s:_MyColColor()
    let cx = &colorcolumn
    let cz = "+1," . col(".")
    if cx != '' && cx == cz
        exec "set cc=\"\""
    else
        exec "set cc=+1," . col(".")
    endif
endfunc
"}}}

"{{{ MyMarkColor
command! MyMarkColor call s:_MyMarkColor()
function! s:_MyMarkColor()
    exec "Mark " . expand("<cword>")
endfunc
"}}}

"{{{ MyMarksBrowser
command! MyMarksBrowser call s:_MyMarksBrowser()
function! s:_MyMarksBrowser()
    let buftype = getbufvar('%', '&filetype')
    if 'marksbuffer' == buftype
        exec "MarksBrowser"
        return
    endif
    if MyFun_is_special_buffer(buftype)
        return
    endif
    exec "MarksBrowser"
endfunction
"}}}

"{{{ MyGoAlternate 如果A发现不了, 使用cs find
command! MyGoAlternate call s:_MyGoAlternate()
function! s:_MyGoAlternate()
    try
        exec "A"
    catch
        let allinfo = v:exception
        let info = split(allinfo, ' ')
        if len(info) != 2
            return
        endif
        let basename = info[0]
        let extensions = info[1]
        for ext in split(extensions, ',')
            try
                exec "cs find f " . basename . "." . ext
                return
            catch /^Vim\%((\a\+)\)\?:E567/
                " no connect
                return
            catch /^Vim\%((\a\+)\)\?:E259/
                " no found
                continue
            endtry
        endfor
        echo "Not found " . basename . ".* file!"
    endtry
endfunction
"}}}