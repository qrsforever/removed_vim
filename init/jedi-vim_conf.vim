" Jedi Setup {{{
" 如果使用YCM实现show_call_signatures 设置如下:
" numpy scipy matplotlib 等第三方库补全存在问题
" https://github.com/davidhalter/jedi/issues/372
" if exists(':NeoCompleteEnable')
"     let g:jedi#popup_on_dot = 0
"     let g:jedi#completions_enabled = 0
"     let g:jedi#smart_auto_mappings = 0
" endif

" if exists(':YcmCompleter')
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#completions_enabled = 0
    let g:jedi#completions_command = ""
    let g:jedi#smart_auto_mappings = 0
" endif

" jedi对非__init__.py文件里面的__all__支持不全, 如果multiprocessing模块
let g:jedi#force_py_version = 3
" 1: buffer 2: cmdline(set cmdheight=2)
let g:jedi#show_call_signatures = 1
" 如果大于0, (后空格才提示补全, Fixme)
let g:jedi#show_call_signatures_delay = 0

" YCM instead of s]
let g:jedi#goto_command = ''
let g:jedi#goto_assignments_command = ''
let g:jedi#rename_command = ''
let g:jedi#usages_command = ',jg'
let g:jedi#documentation_command = 'K'
" goto 不跳转tab
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#auto_close_doc = 1

if &rtp =~ '\<jedi\>'
    augroup JediSetup
        au!
        au FileType python
                    \ setlocal omnifunc=jedi#completions  |
                    \ call jedi#configure_call_signatures()
    augroup END
endif
" }}}
