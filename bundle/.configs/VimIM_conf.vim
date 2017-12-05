"VimIM Setup {{{
" 使用云(qq, sogou, -1)
let g:vimim_cloud = 'baidu'  

" 开关输入发c-_ (切换中文输入法c-^, google,qq,sougo中断了)
" Alt+space(禁掉默认): CompizConfig->general options->key bindings: window menu!
" let g:vimim_map = 'm-space'
" or 直接映射
" imap <M-Space> <C-_>
" nmap <M-Space> <C-_>

" 开启模式(static, dynamic)
let g:vimim_mode = 'dynamic'  
" 0:不使用中文标点 1: 基本 2: 常用中文标点 3:全角
let g:vimim_punctuation = 0
" 双拼设置，abc, ms(微软)
let g:vimim_shuangpin = 0  
" 循环次序
let g:vimim_toggle = 'baidu' 
"}}}
