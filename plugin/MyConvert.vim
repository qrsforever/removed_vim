"{{{ 中文标点转换
command! MyPunctuationConvert call s:_PunctuationConvert()
function! s:_PunctuationConvert() 
   :silent! %s/　/\ /g
   :silent! %s/，/,/g
   :silent! %s/。/./g
   :silent! %s/、/\ /g
   :silent! %s/？/?/g
   :silent! %s/！/!/g
   :silent! %s/；/;/g
   :silent! %s/：/:/g
   :silent! %s/“/"/g
   :silent! %s/”/"/g
   :silent! %s/‘/'/g
   :silent! %s/’/'/g
   :silent! %s/（/(/g
   :silent! %s/）/)/g
endfunction 
"}}}

"{{{ 特殊字符映射 
" set digraph
nmap `<Up>               r△<Esc>
nmap `<Down>             r▽<Esc>
nmap `<Left>             r◁<Esc>
nmap `<Right>            r▷<Esc>
nmap `<PageUp>           r▲<Esc>
nmap `<PageDown>         r▼<Esc>
nmap `<Home>             r◀<Esc>
nmap `<End>              r▶<Esc>
nmap `<Insert>           r◇<Esc>
nmap `<Delete>           r◆<Esc>
nmap `<kPlus>            r☞<Esc>
nmap `<KMinus>           r☜<Esc>
nmap `<KMultiply>        r★<Esc>
nmap `<KDivide>          r♡<Esc>

imap `<Up>          <Esc>r△<Esc>
imap `<Down>        <Esc>r▽<Esc>
imap `<Left>        <Esc>r◁<Esc>
imap `<Right>       <Esc>r▷<Esc>
imap `<PageUp>      <Esc>r▲<Esc>
imap `<PageDown>    <Esc>r▼<Esc>
imap `<Home>        <Esc>r◀<Esc>
imap `<End>         <Esc>r▶<Esc>
imap `<Insert>      <Esc>r◇<Esc>
imap `<Delete>      <Esc>r◆<Esc>
imap `<kPlus>       <Esc>r☞<Esc>
imap `<KMinus>      <Esc>r☜<Esc>
imap `<KMultiply>   <Esc>r★<Esc>
imap `<KDivide>     <Esc>r♡<Esc>

let s:CharConvertState = 0

function! s:_Char2Digraph() 
    :silent! %s/\<e1\>/△\ /g
    :silent! %s/\<e2\>/▽\ /g
    :silent! %s/\<e3\>/◁\ /g
    :silent! %s/\<e4\>/▷\ /g
    :silent! %s/\<c1\>/◇\ /g
    :silent! %s/\<c2\>/◆\ /g
endfunction 

function! s:_Digraph2Char() 
    :silent! %s/△\ /e1/g
    :silent! %s/▽\ /e2/g
    :silent! %s/◁\ /e3/g
    :silent! %s/▷\ /e4/g
    :silent! %s/◇\ /c1/g
    :silent! %s/◆\ /c2/g
endfunction 

command! MyUMLCharConvert call s:CharConvertToogle()
function! s:CharConvertToogle() 
    if s:CharConvertState != 1
        call s:_Char2Digraph()
        let s:CharConvertState = 1
    else
        call s:_Digraph2Char()
        let s:CharConvertState = 0
    endif
endfunction 
"}}}

"{{{ 生成博客对特殊字符处理 hexo blog {{ }} <--> [[ ]]
let s:HexoConvertState = 0
function! s:_Normal2Hexo() 
    :silent! %s/{{/\\{\\{/g
    :silent! %s/}}/\\}\\}/g
    :silent! %s/{#/\\{\\#/g
    :silent! %s/#}/\\#\\}/g
endfunction 

function! s:_Hexo2Normal() 
    :silent! %s/\\{\\{/{{/g
    :silent! %s/\\}\\}/}}/g
    :silent! %s/\\{\\#/{#/g
    :silent! %s/\\#\\}/#}/g

endfunction 

command! MyHexoConvert call s:HexoConvertToogle()
function! s:HexoConvertToogle() 
    if s:HexoConvertState  != 1
        call s:_Normal2Hexo()
        let s:HexoConvertState  = 1
    else
        call s:_Hexo2Normal()
        let s:HexoConvertState  = 0
    endif
endfunction 
"}}}
