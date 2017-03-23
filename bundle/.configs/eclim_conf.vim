
map <unique> <silent> <S-F5> <ESC>:JavaDebugBreakpointToggle!<CR>
map <unique> <silent> <S-F6> <ESC>:JavaDebugStep over<CR>
map <unique> <silent> <S-F7> <ESC>:JavaDebugStep into<CR>
map <unique> <silent> <S-F8> <ESC>:JavaDebugStep return<CR>

let g:EclimCompletionMethod = 'omnifunc'
" let g:EclimBrowser = "chromium-browser"
let g:EclimBrowser = "firefox"
" let g:EclimPythonValidate = 0

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

"severity sort: errors > warnings > info > etc.
let g:EclimValidateSortResults = 'severity'

"Using this local history, you can view diffs against previously saved versions of your file or revert to one of those revisions.
let g:EclimKeepLocalHistory = 1

" autocmd FileType java nmap <C-RightMouse> <esc><c-o>
" autocmd FileType java nmap <C-LeftMouse> <esc>:JavaSearchContext -a edit<cr>
" autocmd BufEnter *.c,*.cpp,*.h silent! unmap <C-LeftMouse>
" autocmd FileType java nmap g] <esc>:JavaSearchContext -a edit<cr>
" autocmd BufEnter *.c,*.cpp,*.h silent! unmap g]

" autocmd FileType java nnoremap <silent> <C-F> :%JavaFormat<cr>
"
" Eclim settings
" nnoremap <silent> ;<cr> :JavaSearchContext -a edit<cr>
" nnoremap <silent> ;;<cr> :JavaSearchContext -a split<cr>
" nnoremap <silent> '<cr> :JavaDocSearch<cr>
" nnoremap <silent> ''<cr> :JavaDocPreview<cr>
nnoremap <silent> <Leader>jv :Validate<cr>
nnoremap <silent> <Leader>jc :JavaCorrect<cr>
nnoremap <silent> <Leader>ji :JavaImport<cr>
nnoremap <silent> <leader>jg :JavaImportOrganize<CR>
" " C-S-F java_format current java file

"修改powerline使之显示在底部状态栏中
"let g:EclimProjectStatusLine = 'eclim(p=${name}, n=${natures})'
" %{eclim#project#util#ProjectStatusLine()}%)

"自动弹出补全
"if !exists('g:neocomplcache_force_omni_patterns')
"    let g:neocomplcache_force_omni_patterns = {}
"endif
"let g:neocomplcache_force_omni_patterns.java = '\k\.\k*'

"功能命令缩短 
"加个Project命令, 主要是为command状态下  :Proj<tab>方便选择
command -nargs=?
            \ -complete=customlist,eclim#project#util#CommandCompleteProject
            \ Project :call eclim#project#util#ProjectList('<args>')

" nnoremap <silent> <leader>pl :ProjectList<cr>
" nnoremap <silent> <leader>pt :ProjectTreeToggle<cr>
nnoremap <silent> <leader>pi :call DoCurrentProject(0)<CR>
" nnoremap <silent> <leader>po :call DoCurrentProject(1)<CR>
" nnoremap <silent> <leader>pc :call DoCurrentProject(2)<CR>
nnoremap <silent> <leader>pd :call DoCurrentProject(3)<CR>
nnoremap <silent> <leader>pp :call DoSelectProjects()<CR>
nnoremap <silent> <leader>ps :call DoProjectSearch()<CR>

command -nargs=? SelectProeject :call DoSelectProjects()

"通过当前编辑的文件, 打开所在的Android工程, 最终方便实现代码补全功能.
func! DoCurrentProject(flag) "{{{
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
        echo "classOrInterface[1] method[2] field[3] enum[4] type[5]  "
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

" func! MyJavaSearchContext() 
"     let search=expand('<cword>') 
"     if len(search) == 0
"         return
"     endif
"     let params=' -p ' . search . ' -t classOrInterface' . ' -x declarations -a edit'
"     call eclim#java#search#SearchAndDisplay('java_search', params)
" endfunc
" 
" func! MyJavaSearchMethod() 
"     let search=expand('<cword>') 
"     if len(search) == 0
"         return
"     endif
"     let params=' -p ' . search . ' -t method' . ' -x declarations -a edit'
"     call eclim#java#search#SearchAndDisplay('java_search', params)
" endfunc

" command JSC    JavaSearchContext -a edit
" command JSCS   JavaSearchContext -a split
" command J      JSC
" 
" command JDS    JavaDocSearch 
" command JDP    JavaDocPreview

"<jvmarg value="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=1044"/> 
command XDStart JavaDebugStart localhost 1044
command XDStop  JavaDebugStop 
command XDList  JavaDebugBreakpointsList!
" 
command -nargs=? J  :call DoProjectSearch(0, 0, 0)
command -nargs=? J1 :call DoProjectSearch(1, 0, 0)
command -nargs=? J2 :call DoProjectSearch(2, 0, 0)
command -nargs=? J3 :call DoProjectSearch(3, 0, 0)
command -nargs=? J4 :call DoProjectSearch(4, 0, 0)
command -nargs=? J5 :call DoProjectSearch(5, 0, 0)

command -nargs=? M1 :call DoProjectSearch(1, 1, 0)
command -nargs=? M2 :call DoProjectSearch(2, 1, 0)
command -nargs=? M3 :call DoProjectSearch(3, 1, 0)
command -nargs=? M4 :call DoProjectSearch(4, 1, 0)
command -nargs=? M5 :call DoProjectSearch(5, 1, 0)
command -nargs=? S1 :call DoProjectSearch(1, 1, 1)
command -nargs=? S2 :call DoProjectSearch(2, 1, 1)
command -nargs=? S3 :call DoProjectSearch(3, 1, 1)
command -nargs=? S4 :call DoProjectSearch(4, 1, 1)
command -nargs=? S5 :call DoProjectSearch(5, 1, 1)

command M J
command S J
