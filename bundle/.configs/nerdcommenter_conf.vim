"Default mapping:
"[count],cc   " 以行为单位进行注释.
" ,c<space>     " comment , <--> , uncomment.   ( 常用 )
" ,cm           " 一段为单位进行注释. ( 常用 )
" ,cs           " 简洁美观式注释.  ( 常用 , 可以嵌套注释,用,cu取消注释 )
" ,cy           " Same as ,cc except that the commented line(s) are yanked first.
" ,c$           " 注释当前光标到行末的内容.
" ,cA           " 在行末进行手动输入注释内容.
" ,ca           " 切换注释方式(/**/ <--> //).   ( 常用 )
" ,cl           " Same cc, 左对齐.
" ,cb           " Same cc, 两端对其.
" ,cu           " Uncomments the selected line(s).  ( 常用 )
let NERDSpaceDelims = 1       " 让注释符与语句之间留1个空格
let NERDCompactSexyComs = 1   " 多行注释时样子更好看
let NERD_c_alt_style = 1
let NERDRemoveExtraSpaces = 1
let NERDMenuMode = 0

" 不知道什么原因python注释总多一个空格, 所以这里'#'后面的空格去掉
let g:NERDCustomDelimiters = {
    \ 'python': { 'left': '#', 'leftAlt': '#' },
\ }
