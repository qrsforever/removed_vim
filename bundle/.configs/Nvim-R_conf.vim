"Nvim-R Setup{{{
"
" <LocalLeader> --> \

" Auto start/stop when edit R file
" autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif   
" autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
" autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif 

" 常用map
" . Start R (default)                                  \rf
" . Close R (no save)                                  \rq
" . Clear console                                      \rr
" . Clear all                                          \rm (变量引用全清除)
" . View data.frame (cur)                              \rv
" . Help (cur)                                         \rh
" . Arguments (cur)                                    \ra
" . Show/Update                                        \ro (Objects Show)

" xterm / gnome-terminal
" let R_term = "gnome-terminal"

" disable: _ replace <-
let R_assign = 0

let R_objbr_place = "script,left"
let R_objbr_w = 35
let R_objbr_h = 35
let R_objbr_opendf = 1    " Show data.frames elements
let R_objbr_openlist = 0  " Show lists elements
let R_objbr_allnames = 0  " Show .GlobalEnv hidden objects
let R_objbr_labelerr = 1  " Warn if label is not a valid text

" let R_args = ['--no-save', '--quiet']
" let R_start_libs = "base,stats,graphics,grDevices,utils,methods"

" let R_rconsole_width = 65
" let R_min_editor_width = 65
" autocmd VimResized * let R_rconsole_width = winwidth(0) / 2

" \ra: 显示method参数
let R_listmethods = 1

let R_complete = 2

" 补全
imap <C-A> <Plug>RCompleteArgs 

" 快捷键:
" \; --> 右侧注释 
"
" \xc --> toggle 注释 (废掉)

"}}}
 
" 鼠标+左手操作方便{{{
function! RPrintRObject()
    let curline = line(".")
    let line = getline(curline)
    if strlen(line) == 0
        return ""
    endif
    let arr = split(line, "=")
    if len(arr) >= 2
        call PrintRObject(substitute(arr[0], '\s\+$', '', 'g'))
    endif
endfunction
nmap <silent> <unique> E :call RPrintRObject()<CR>
"}}}
