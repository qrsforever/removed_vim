let g:EclimCompletionMethod = 'omnifunc'
" let g:EclimBrowser = "chromium-browser"
let g:EclimBrowser= "google-chrome"
" let g:EclimBrowser = "firefox"

let g:EclimJavaDebugStatusWinWidth = 80
let g:EclimJavaDebugStatusWinHeight = 30
" let g:EclimJavaDebugLineSignText = "^"

"open:使用浏览器打开, lopen就vim打开
let g:EclimJavaDocSearchSingleResult = "open" 

let g:EclimLocationListHeight = 24

let g:EclimAntCompilerAdditionalErrorFormat =
            \ '\%A%.%#[xslt]\ Loading\ stylesheet\ %f,' .
            \ '\%Z%.%#[xslt]\ %.%#:%l:%c:\ %m,'
let g:EclimAntErrorsEnabled = 1

" let g:EclimJavaValidate=0
" let g:EclimPythonValidate = 0
" let g:EclimMakeLCD=0

"severity sort: errors > warnings > info > etc.
let g:EclimValidateSortResults = 'severity'

"Using this local history, you can view diffs against previously saved versions of your file or revert to one of those revisions.
let g:EclimKeepLocalHistory = 1

" 禁止mvn自动更新classpath文件， 可以手动更新:Mvn dependency:resolve
let g:EclimMavenPomClasspathUpdate = 0

"修改powerline使之显示在底部状态栏中
"let g:EclimProjectStatusLine = 'eclim(p=${name}, n=${natures})'
" %{eclim#project#util#ProjectStatusLine()}%)

"功能命令缩短 
"加个Project命令, 主要是为command状态下  :Proj<tab>方便选择
command -nargs=?
            \ -complete=customlist,eclim#project#util#CommandCompleteProject
            \ Project :call eclim#project#util#ProjectList('<args>')

"通过当前编辑的文件, 打开所在的Android工程, 最终方便实现代码补全功能.
func! DoCurrentProject(flag) "{{{
    exec "lchdir %:p:h"
    let curdir = getcwd()
    while len(curdir) > 12 
        let children = vimproc#readdir(curdir)
        for child in children
            let child = substitute(child, '\/$', '', '')
            if isdirectory(child)
                continue
            endif

            let filen = strpart(child, len(child) - 8)
            if '.project' ==# filen
                let lines = readfile(child)
                for i in lines
                    let content = matchstr(i, '<name>\(\w*\W*\w*\)</name>')
                    if len(content) > 0 
                        let proname = strpart(content, 6, len(content) - 13)
                        if len(proname) > 0
                            if a:flag == 0
                                echo 'Import project: ' . curdir
                                call eclim#project#util#ProjectImport(curdir)
                            elseif a:flag == 1
                                echo 'Open project: ' . proname
                                call eclim#project#util#ProjectOpen(proname)
                            elseif a:flag == 2
                                echo 'Close project: ' . proname
                                call eclim#project#util#ProjectClose(proname)
                            elseif a:flag == 3
                                echo 'Delete project: ' . proname
                                call eclim#project#util#ProjectDelete(proname)
                            else 
                                echo 'Never run here.'
                            endif
                        endif
                        return ''
                    endif
                endfor
            endif
        endfor
        let pathpos = strridx(curdir, '/')
        let curdir = strpart(curdir, 0, pathpos)
    endwhile
endfunc"}}}

func! DoSelectProjects() "{{{
    let op = str2nr(input("Select List[0] Open[1] Close[2] Delete[3] ", ' '), 10)   
    if op == 0
        call eclim#project#util#ProjectList('')
        return 
    endif

    let names = eclim#project#util#GetProjectNames()
    let i = 0
    echomsg ' '
    echomsg ' ' . i . ' Select all project'
    for n in names
        let i = i + 1
        echomsg ' ' . i . ' ' . n 
    endfor

    let tmpstr = input("Select project: ", ' ')
    if tmpstr == '' || tmpstr == ' '
        return 
    endif
    let tokpos = stridx(tmpstr, ',')
    if tokpos > 0
        let select = split(tmpstr, ',')
    else
        let select = split(tmpstr)
    endif
    let len = len(select)
    if len < 0 && len > i
        return
    endif

    let i = 0
    for proname in names
        let i = i + 1
        if select[0] == 0 && len == 1
            if op == 1
                echo 'Open project: ' . proname
                call eclim#project#util#ProjectOpen(proname)
                silent! exec 'NERDTree ' . eclim#project#util#GetProjectRoot(proname)  
            elseif op == 2
                echo 'Close project: ' . proname
                call eclim#project#util#ProjectClose(proname)
            elseif op == 3 
                echo 'Delete project: ' . proname
                call eclim#project#util#ProjectDelete(proname)
            else 
                echomsg "Never run here."
            endif
            continue
        endif

        let j = 0
        while j < len
            let s = str2nr(select[j], 10)
            if s == i
                break
            endif
            let j = j + 1
        endwhile

        if j >= len
            continue
        endif

        if op == 1
            echo 'Open project: ' . proname
            call eclim#project#util#ProjectOpen(proname)
            silent! exec 'NERDTree ' . eclim#project#util#GetProjectRoot(proname)  
        elseif op == 2
            echo 'Close project: ' . proname
            call eclim#project#util#ProjectClose(proname)
        elseif op == 3 
            echo 'Delete project: ' . proname
            call eclim#project#util#ProjectDelete(proname)
        else 
            echomsg "Never run here."
        endif
    endfor
endfunc"}}}

func! DoProjectSearch(flag, xp, split) "{{{
    let search=expand('<cword>') 
    if len(search) == 0
        return
    endif
    let op = a:flag
    if a:flag == 0
        echomsg "J(all) - M(declaration) - S(plit)"
        echomsg "classOrInterface[1] method[2] field[3] enum[4] type[5]  "
        let op = str2nr(input("Select:", ' '), 10)
    endif
    if a:xp == 0
        let var_x="all"
    else
        let var_x="declarations"
    endif
    if a:split == 0
        let var_s="edit"
    else 
        let var_s="split"
    endif
    if  op == 1 
        let param="classOrInterface"
    elseif op == 2
        let param="method"
    elseif op == 3
        let param="field"
    elseif op == 4
        let param="enum"
    elseif op == 5
        let param="type"
    else 
        return 
    endif
    let params=' -p ' . search . ' -t ' . param . ' -x ' . var_x . ' -a ' . var_s
    call eclim#java#search#SearchAndDisplay('java_search', params)
endfunc"}}}

func! DoCtrlLeftMouse() abort "{{{
    let word = expand("<cword>")

    " 1. not support ctag, return
    if &ft != 'c' || &ft != 'cpp' || &ft != 'python' || &ft != 'java'
        return
    endif

    " 1. eclim
    if &ft == 'java' && eclim#EclimAvailable(0)
        let ret = eclim#java#search#SearchAndDisplay('java_search', '-a edit')
        if ret == 1
            return
        endif
    endif

    " 2. ycm
    if exists('g:loaded_unite')
        let result = unite#util#redir('YcmCompleter GoToDefinitionElseDeclaration')
        if result == '' || matchstr(result, "Error") == ''
            return
        endif
    endif

    " 3. tag
    exec "tag " . word
    exec "normal zt"
endfunc"}}}

func! DoCtrlRightMouse() "{{{
    if &ft == 'java' && eclim#EclimAvailable(0)
        exec 'normal! ' .  "\<c-o>"
        return
    endif
    let result = unite#util#redir('silent! pop')
    if result != '' && matchstr(result, "Error") != ''
        exec 'normal! ' .  "\<c-o>"
        return
    endif
    " ctrl-t
    exec "silent! pop"
endfunc"}}}

"<jvmarg value="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=1044"/> 
command XDStart JavaDebugStart localhost 1044
command XDStop  JavaDebugStop 
command XDList  JavaDebugBreakpointsList!
" 
command -nargs=? J  :call DoProjectSearch(0, 0, 0)

command -nargs=? J1 :call DoProjectSearch(1, 1, 0)
command -nargs=? J2 :call DoProjectSearch(2, 1, 0)
command -nargs=? J3 :call DoProjectSearch(3, 1, 0)
command -nargs=? J4 :call DoProjectSearch(4, 1, 0)
command -nargs=? J5 :call DoProjectSearch(5, 1, 0)

command -nargs=? M1 :call DoProjectSearch(1, 0, 0)
command -nargs=? M2 :call DoProjectSearch(2, 0, 0)
command -nargs=? M3 :call DoProjectSearch(3, 0, 0)
command -nargs=? M4 :call DoProjectSearch(4, 0, 0)
command -nargs=? M5 :call DoProjectSearch(5, 0, 0)

command -nargs=? S1 :call DoProjectSearch(1, 1, 1)
command -nargs=? S2 :call DoProjectSearch(2, 1, 1)
command -nargs=? S3 :call DoProjectSearch(3, 1, 1)
command -nargs=? S4 :call DoProjectSearch(4, 1, 1)
command -nargs=? S5 :call DoProjectSearch(5, 1, 1)

command M J
command S J

" nnoremap [eclim] <Nop>
" nmap ; [eclim]

nnoremap <silent> ;c  <esc>:JavaSearchContext -a edit<CR>
nnoremap <silent> ;sc <esc>:JavaSearchContext -a split<CR>
nnoremap <silent> ;d  <esc>:JavaDocSearch<CR>
nnoremap <silent> ;sd <esc>:JavaDocPreview<CR>

nnoremap <silent> ;pi <esc>:call DoCurrentProject(0)<CR>
nnoremap <silent> ;po <esc>:call DoCurrentProject(1)<CR>
nnoremap <silent> ;pc <esc>:call DoCurrentProject(2)<CR>
nnoremap <silent> ;pd <esc>:call DoCurrentProject(3)<CR>
nnoremap <silent> ;pp <esc>:call DoSelectProjects()<CR>

nnoremap <silent> ;jv <esc>:Validate<CR>
nnoremap <silent> ;jc <esc>:JavaCorrect<CR>
nnoremap <silent> ;ji <esc>:JavaImport<CR>
nnoremap <silent> ;jg <esc>:JavaImportOrganize<CR>

nnoremap <silent> <C-LeftMouse>  <esc>:call DoCtrlLeftMouse()<CR>
nnoremap <silent> <C-RightMouse> <esc>:call DoCtrlRightMouse()<CR>
nnoremap <silent> g]  <esc>:call DoCtrlLeftMouse()<CR>


" map <unique> <silent> <S-F5> <ESC>:JavaDebugBreakpointToggle!<CR>
" map <unique> <silent> <S-F6> <ESC>:JavaDebugStep over<CR>
" map <unique> <silent> <S-F7> <ESC>:JavaDebugStep into<CR>
" map <unique> <silent> <S-F8> <ESC>:JavaDebugStep return<CR>
