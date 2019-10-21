function! MyFun_is_special_buffer(bt) "{{{
    let buftype = a:bt != '' ? a:bt : getbufvar('%', '&filetype')
    let buffers = ['nerdtree', 'tagbar', 'qf', 'unite', 'lookupfile', 'bufexplorer', 'marksbuffer', 'vimshell', 'leaderf']
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
        execute "silent! botright " . a:cmd . " " . h
    elseif a:place == 1
        execute "silent! topleft " . a:cmd . " " . h
    elseif a:place == 2
        execute "silent! belowright " . a:cmd . " " . h
    elseif a:place == 3
        execute "silent! aboveleft " . a:cmd . " " . h
    else
        let w = winwidth(0) / 2 - 5
        if w < 5
            execute "silent! vertical " . a:cmd . " ". w
        else
            execute "silent! vertical " . a:cmd
        endif
    endif
endfunction
"}}}

"{{{ MyColColor
autocmd FileType nerdtree,tagbar,lookupfile setlocal cc=""
command! MyColColor call s:_MyColColor()
function! s:_MyColColor()
    let cx = &colorcolumn
    let cz = "+1,86," . col(".")
    if cx != '' && cx == cz
        exec "set cc=\"\""
    else
        "+1表示textwidth后一列标亮
        exec "set cc=+1,86," . col(".")
    endif
endfunc
"}}}

"{{{ MyBufExplorer 
command! MyBufExplorer call s:DoBufExplorer()
function! s:DoBufExplorer()
    let buftype = getbufvar('%', '&filetype')
    let ret = MyFun_is_special_buffer(buftype)
    if ret == 0
        exec 'normal \<esc>'
        exec 'Leaderf! buffer --fullScreen --nowrap'
    else
        if buftype ==# 'leaderf'
            execute "normal q"
        endif
    endif
endfunction
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

"{{{MyDoSave
command! MyDoSave call s:_MyDoSave()
function! s:_MyDoSave()
    exec 'norm! \<ESC>'
    exec 'silent update!'
    exec 'silent lchdir %:p:h'
    call setreg('p', 'a'. expand('%:p'))

    "@p
    echo "[" . hostname() . '] ' . getcwd()
endfunction
"}}}
