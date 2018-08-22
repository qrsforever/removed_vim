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
    let g:jedi#auto_initialization = 0
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#completions_enabled = 0
    let g:jedi#completions_command = ""
    let g:jedi#smart_auto_mappings = 0
" endif

let g:jedi#force_py_version = 3
" 1: buffer 2: cmdline(set cmdheight=2)
let g:jedi#show_call_signatures = 1
" 如果大于0, (后空格才提示补全, Fixme
let g:jedi#show_call_signatures_delay = 0

" let g:jedi#completions_command = "<C-N>"
let g:jedi#goto_command = ''
let g:jedi#goto_assignments_command = ';a'
let g:jedi#goto_definitions_command = ';d'
let g:jedi#usages_command = ''
let g:jedi#rename_command = ''

if &rtp =~ '\<jedi\>'
    augroup JediSetup
        au!
        au FileType python
                    \ setlocal omnifunc=jedi#completions  |
                    \ call jedi#configure_call_signatures()
    augroup END
endif
" }}}
