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
let R_term = "gnome-terminal"
" disable: _ replace <-
let R_assign = 0

let R_objbr_place = "script,left"
let R_objbr_w = 35
let R_objbr_h = 35

let R_args = ['--no-save', '--quiet']
let R_start_libs = "base,stats,graphics,grDevices,utils,methods"

" let R_rconsole_width = 40

" \ra: 显示method参数
let R_listmethods = 1

" 补全
imap <C-A> <Plug>RCompleteArgs 

"}}}
