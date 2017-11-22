"echo "!_TAG_FILE_SORTED	2	/2=foldcase/"; find . -not -iregex '.*\.\(jar\|gif\|jpg\|class\|exe\|dll\|pdd\|sw[op]\|xls\|doc\|pdf\|zip\|tar\|ico\|ear\|war\|dat\).*' -type f -printf "%f\t%p\t1\n" |  sort -f > ./filenametags
let g:LookupFile_MinPatLength = 3               "最少输入3个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
let g:LookupFile_SortMethod = ""                "关闭对搜索结果的字母排序
let g:LookupFile_UpdateTime = 200
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_RecentFileListSize = 20
let g:LookupFile_OnCursorMovedI = 1
let g:LookupFile_SearchForBufsInTabs = 1
let g:LookupFile_EscCancelsPopup = 1 
let g:LookupFile_DisableDefaultMap = 1 "F5
" let g:LookupFile_EnableRemapCmd=1
let g:LookupFile_DefaultCmd = ':LUTags'

" Don't display binary files
let g:LookupFile_FileFilter = '\.class$\|\.o$\|\.obj$\|\.exe$\|\.jar$\|\.zip$\|\.war$\|\.ear$\|\.bak$\|\tag$'
let g:LookupFile_TagExpr=string('filenametags')
"映射LookupFile为,lk
" nmap <silent> <leader>lk :LUTags<cr>
"映射LUBufs为,ll
" nmap <silent> <leader>ll :LUBufs<cr>
"映射LUWalk为,lw
" nmap <silent> <leader>lw :LUWalk<cr>
" lookup file with ignore case
function! LookupFile_IgnoreCaseFunc(pattern)
    let _tags = &tags
    try
        let &tags = eval(g:LookupFile_TagExpr)
        let newpattern = '\c' . a:pattern
        let tags = taglist(newpattern)
    catch
        echohl ErrorMsg | echo "Exception: " . v:exception | echohl NONE
        return ""
    finally
        let &tags = _tags
    endtry

    " Show the matches for what is typed so far.
    let files = map(tags, 'v:val["filename"]')
    return files
endfunction
let g:LookupFile_LookupFunc = 'LookupFile_IgnoreCaseFunc'

" let g:LookupFile_LookupAcceptFunc = 'xxx'

" <C-T>: tabedit
" <C-S>: split 
" <C-V>: vsplit

let s:ToggleFlag = 0
command! MyLookupFile call s:DoLookupFile()
func! s:DoLookupFile() "{{{
    let buftype = getbufvar('%', '&filetype')
    let ret = MyFun_is_special_buffer(buftype)
    if ret == 0
        " 如果Eclimd启动,并没有设置LookupFile_TagExpr, 使用eclimd
        if g:LookupFile_TagExpr == "'filenametags'"
            if isdirectory(expand('~/.vim/bundle/eclim'))
                if eclim#EclimAvailable(0)
                    if s:ToggleFlag != 1
                        let s:ToggleFlag = 1
                        exec "LocateFile"
                    else 
                        let s:ToggleFlag = 0
                        " exec "cclose"
                    endif
                endif
            endif
            return 
        else
            exec "LookupFile"
        endif
    else
        if 'lookupfile' ==# buftype
            exec "q"
        endif
    endif
endfunc"}}}
