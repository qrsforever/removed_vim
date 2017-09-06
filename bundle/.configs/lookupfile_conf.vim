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

" 插件已被修改, 在buff模式下, 映射关系如下:
" <C-L>: tabedit 有冲突 使用<C-H>
" <C-J>: split 
" <C-K>: vsplit
"<C-O>       i       Same as <CR>, except that the file opens in a split
"
command! MyLookupFile call s:DoLookupFile()
func! s:DoLookupFile() "{{{
    let buftype = getbufvar('%', '&filetype')
    let ret = MyFun_is_special_buffer(buftype)
    if ret == 0
        exec "LookupFile"
    else
        if 'lookupfile' ==# buftype
            exec "q"
        endif
    endif
endfunc"}}}
