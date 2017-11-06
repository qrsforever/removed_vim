"UML特殊字符映射 "{{{
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

"}}}

let s:ConvertState = 0

command! UMLChar2Digraph call s:_Char2Digraph()
function! s:_Char2Digraph() "{{{
    :silent! %s/\<e1\>/△\ /g
    :silent! %s/\<e2\>/▽\ /g
    :silent! %s/\<e3\>/◁\ /g
    :silent! %s/\<e4\>/▷\ /g
    :silent! %s/\<c1\>/◇\ /g
    :silent! %s/\<c2\>/◆\ /g
endfunction "}}}

command! UMLDigraph2Char call s:_Digraph2Char()
function! s:_Digraph2Char() "{{{
    :silent! %s/△\ /e1/g
    :silent! %s/▽\ /e2/g
    :silent! %s/◁\ /e3/g
    :silent! %s/▷\ /e4/g
    :silent! %s/◇\ /c1/g
    :silent! %s/◆\ /c2/g
endfunction "}}}

command! MyUMLCharConvert call s:CharConvertToogle()
function! s:CharConvertToogle() "{{{
    if s:ConvertState != 1
        call s:_Char2Digraph()
        let s:ConvertState = 1
    else
        call s:_Digraph2Char()
        let s:ConvertState = 0
    endif
endfunction "}}}
