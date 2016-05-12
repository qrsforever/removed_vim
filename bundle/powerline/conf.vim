"修改插件使得能够显示文件路径,修改~/.vim/bundle/powerline/autoload/PowerLine/Segments.vim:(line:9)Pl#Segment#Create('filename', '%F') (%t -- > %F)
"在Themes/default.vim添加elimd工程名字programname显示
let g:Powerline_symbols = 'unicode'
let g:Powerline_theme = 'default'
let g:Powerline_colorscheme = 'solarized256'
let g:Powerline_stl_path_style = 'short'
" call Pl#Theme#InsertSegment('currenttag', 'after', 'fileinfo') "默认已添加
"配合powerline.vim时时在状态栏中显示函数名
"function! GetProtoLine()
"  let ret       = ""
"  let line_save = line(".")
"  let col_save  = col(".")
"  let top       = line_save - winline() + 1
"  let so_save = &so
"  let &so = 0
"  let istypedef = 0
"  " find closing brace
"  let closing_lnum = search('^}','cW')
"  if closing_lnum > 0
"    if getline(line(".")) =~ '\w\s*;\s*$'
"      let istypedef = 1
"      let closingline = getline(".")
"    endif
"    " go to the opening brace
"    normal! %
"    " if the start position is between the two braces
"    if line(".") <= line_save
"      if istypedef
"        let ret = matchstr(closingline, '\w\+\s*;')
"      else
"        " find a line contains function name
"        let lnum = search('^\w','bcnW')
"        if lnum > 0
"          let ret = getline(lnum)
"        endif
"      endif
"    endif
"  endif
"  " restore position and screen line
"  exe "normal! " . top . "Gz\<CR>"
"  call cursor(line_save, col_save)
"  let &so = so_save
"  return ret
"endfunction
"
"function! WhatFunction()
"  if &ft != "c" && &ft != "cpp"
"    return ""
"  endif
"  let proto = GetProtoLine()
"  if proto == ""
"    return "?"
"  endif
"  if stridx(proto, '(') > 0
"    let ret = matchstr(proto, '\w\+(\@=')
"  elseif proto =~# '\<struct\>'
"    let ret = matchstr(proto, 'struct\s\+\w\+')
"  elseif proto =~# '\<class\>'
"    let ret = matchstr(proto, 'class\s\+\w\+')
"  else
"    let ret = strpart(proto, 0, 15) . "..."
"  endif
"  return ret
"endfunction
" set titlestring=Function:%{WhatFunction()}
" "因为其他插件配合PowerLine总有问题，所以需要自己实现
" 修改~/.vim/bundle/powerline/autoload/Powerline/Segments.vim, 将上面的的函数写到Segments.vim,并在最后添加:
"     \ Pl#Segment#Create('currenttag'        , '%{WhatFunction()}', Pl#Segment#Modes('!N')),
" 同时有时需要修改.vimrc:  call Pl#Theme#InsertSegment('currenttag', 'after', 'fileinfo') "default主题默认已添加,所以不需要
" 或者写到function.vim更好
