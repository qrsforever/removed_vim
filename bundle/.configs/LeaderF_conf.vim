"{{{ Setup

let g:Lf_ShortcutF = '@nullf'
let g:Lf_ShortcutB = '@nullb'
let g:Lf_WindowPosition = 'bottom'
let g:Lf_WindowHeight = '0.5'
let g:Lf_TabpagePosition = 3
let g:Lf_ShowRelativePath = 0
let g:Lf_CursorBlink = 1
let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_MruFileExclude = ['*.so', '*.class', '*.o']
let g:Lf_MruMaxFiles = 120
let g:Lf_UseVersionControlTool = 1
let g:Lf_DefaultExternalTool = 'rg'
let g:Lf_UseCache = 1
let g:Lf_StlColorscheme = 'powerline'

let g:Lf_Ctags = 'ctags'
let g:Lf_CtagsFuncOpts = {
    \ 'c': '-I __THROW --c++-kinds=+p --c-kinds=fp --fields=+ialS --extras=+q',
    \ 'rust': '--rust-kinds=f',
\ }

let g:Lf_RgConfig = [
    \ "--max-columns=0",
    \ "--case-sensitive",
    \ "--glob=!git/*",
\ ]


let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg','out','output'],
    \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.class','*.so','*.py[co]']
\ }

let g:Lf_PreviewResult = {
    \ 'File': 0,
    \ 'Buffer': 0,
    \ 'Mru': 0,
    \ 'Tag': 0,
    \ 'BufTag': 0,
    \ 'Function': 0,
    \ 'Line': 0,
    \ 'Colorscheme': 0
\}

let g:Lf_RootMarkers = ['.project', '.svn', '.git', '.hg', '.gradle']
let g:Lf_HideHelp = 1

let g:Lf_StlPalette = {
    \ 'stlBlank': {
        \ 'gui': 'NONE',
        \ 'font': 'NONE',
        \ 'guifg': 'NONE',
        \ 'guibg': '#303136',
        \ 'cterm': 'NONE',
        \ 'ctermfg': '145',
        \ 'ctermbg': '236'
        \},
\}

let g:Lf_CommandMap = {
    \ '<C-X>': ['<C-S>'],
    \ '<C-]>': ['<C-V>'],
    \ '<C-J>': ['<C-N>'],
    \ '<C-K>': ['<C-P>'],
\}

"    <C-C>, <ESC> : quit from LeaderF.
"    <C-R> : switch between fuzzy search mode and regex mode.
"    <C-F> : switch between full path search mode and name only search mode.
"    <Tab> : switch to normal mode.
"    <C-V>, <S-Insert> : paste from clipboard.
"    <C-U> : clear the prompt.
"    <C-J>, <C-K> : navigate the result list.
"    <Up>, <Down> : recall last/next input pattern from history.
"    <2-LeftMouse> or <CR> : open the file under cursor or selected(when
"                            multiple files are selected).
"    <C-X> : open in horizontal split window.
"    <C-]> : open in vertical split window.
"    <C-T> : open in new tabpage.
"    <F5>  : refresh the cache.
"    <C-LeftMouse> or <C-S> : select multiple files.
"    <S-LeftMouse> : select consecutive multiple files.
"    <C-A> : select all files.
"    <C-L> : clear all selections.
"    <BS>  : delete the preceding character in the prompt.
"    <Del> : delete the current character in the prompt.
"    <Home>: move the cursor to the begin of the prompt.
"    <End> : move the cursor to the end of the prompt.
"    <Left>: move the cursor one character to the left.
"    <Right> : move the cursor one character to the right.
"    <C-P> : preview the result.

function! s:DoLeaderfFileWithPath()
    let dirstr = input("Searching from: ", getcwd(), "dir")
    if dirstr == ""
        return
    endif
    exec 'LeaderfFile ' . dirstr
endfunc

" function! s:DoBufExplorer()
"     exec 'normal \<esc>'
"     exec 'normal sb'
" endfunc
" command! MyBufExplorer call s:DoBufExplorer()

function! s:DoLeaderfRgWithPath(cwd, nwrap, cbuf, icase, append)
    let key = expand("<cword>")
    if a:cwd != 1 || len(key) < 2
        let key = input("Searching pattern: ", key)
    endif
    if key == ""
        return
    endif
    let tmpstr = ''
    let dirstr = ''
    if a:nwrap == 1
        let tmpstr = tmpstr . ' --nowrap'
    endif
    if a:icase == 1
        let tmpstr = tmpstr . ' --ignore-case'
    endif
    if a:append == 1
        let tmpstr = tmpstr . ' --append'
    endif
    if a:cbuf == 1
        exec "lchdir %:p:h"
        let tmpstr = tmpstr . ' --current-buffer'
    else
        let dirstr = input("Searching from: ", getcwd(), "dir")
        if dirstr == ""
            return
        endif
        let tmpstr = tmpstr . ' --stayOpen'
    endif
    exec 'Leaderf! rg' . tmpstr . ' -e ' key . ' ' . dirstr
endfunc
"}}}

" usage: Leaderf[!] [-h] [--reverse] [--stayOpen] [--input <INPUT> | --cword]
" [--top | --bottom | --left | --right | --belowright | --aboveleft | --fullScreen]
" [--nameOnly | --fullPath | --fuzzy | --regexMode] [--nowrap]
" {file,tag,function,mru,searchHistory,cmdHistory,help,line,colorscheme,self,bufTag,buffer,rg}

" Warning conflict with unite.vim or fuzzyfinder
nnoremap <unique> <silent> [search]b :<C-U>Leaderf! buffer --fullScreen --nameOnly --nowrap<CR>
nnoremap <unique> <silent> [search]c :<C-U>Leaderf! cmdHistory<CR>
nnoremap <unique> <silent> [search]s :<C-U>Leaderf! searchHistory<CR>

" 搜索[当前目录]中的文件
nnoremap <unique> <silent> [search]f :<C-U>LeaderfFile<CR>
nnoremap <unique> <silent> [search]F :call <SID>DoLeaderfFileWithPath()<CR>

" 搜索[当前字符]最近文件
nnoremap <unique> <silent> [search]n :<C-U>Leaderf! mru --nowrap<CR>
nnoremap <unique> <silent> [search]N :<C-U>Leaderf mru --cword --regexMode --nowrap<CR>

" 查找[所有]buffer中某个函数名或变量
nnoremap <unique> <silent> [search], :<C-U>Leaderf bufTag --nowrap --stayOpen<CR>
nnoremap <unique> <silent> [search]< :<C-U>Leaderf bufTag --all --nowrap --stayOpen<CR>

" 查找[所有]buffer中的某个函数
nnoremap <unique> <silent> [search]. :<C-U>Leaderf function --nowrap --stayOpen<CR>
nnoremap <unique> <silent> [search]> :<C-U>Leaderf function --all --nowrap --stayOpen<CR>

" 从Tag文件中查找某个函数或变量名 (], })留给YCM使用
nnoremap <unique> <silent> [search][ :<C-U>Leaderf tag --cword --regexMode --nowrap<CR>
nnoremap <unique> <silent> [search]{ :<C-U>Leaderf tag --nowrap --stayOpen<CR>

" 搜索字符串 parameter(--cword --nowrap --current-buffer --ignore-case --append)
nnoremap <unique> <silent> [search]g :call <SID>DoLeaderfRgWithPath(1, 1, 1, 1, 0)<CR>
nnoremap <unique> <silent> [search]G :call <SID>DoLeaderfRgWithPath(0, 1, 1, 1, 0)<CR>
nnoremap <unique> <silent> [search]+ :call <SID>DoLeaderfRgWithPath(1, 1, 1, 1, 1)<CR>
nnoremap <unique> <silent> [search]/ :call <SID>DoLeaderfRgWithPath(1, 1, 0, 1, 0)<CR>
nnoremap <unique> <silent> [search]? :call <SID>DoLeaderfRgWithPath(0, 1, 0, 1, 0)<CR>
nnoremap <unique> <silent> [search]w :Leaderf! rg --nowrap --stayOpen --recall<CR><CR>
