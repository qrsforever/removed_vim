" Jedi Setup {{{
" 如果使用YCM实现show_call_signatures 设置如下: 
" numpy scipy matplotlib 等第三方库补全存在问题
" https://github.com/davidhalter/jedi/issues/372
if exists(':NeoCompleteEnable')
    let g:jedi#popup_on_dot = 0
endif
let g:jedi#auto_initialization = 0
" 1: buffer 2: cmdline(set cmdheight=2)
let g:jedi#show_call_signatures = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#show_call_signatures_delay = 0
if &rtp =~ '\<jedi\>'
    augroup JediSetup
        au!
        au FileType python
            \ setlocal omnifunc=jedi#completions  |
            \ call jedi#configure_call_signatures()
    augroup END
endif
" }}}
