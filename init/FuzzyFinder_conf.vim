"{{{
let g:fuf_previewHeight = 0     "预览高度
let g:fuf_enumeratingLimit = 100 "符合条件的最多显示20个
" ['file', 'dir', 'buffer', 'line', 'changelist',  'tag', 'mrucmd', 'quickfix', \
" 'buffertag', 'help', 'taggedfile', 'coveragefile', 'jumplist', 'mrufile', 'buffertag']
let g:fuf_modesDisable = [
     \ 'file', 'dir', 'buffer', 'line', 'mrucmd',
     \ 'tag', 'buffertag', 'help', 'taggedfile',
     \ 'jumplist', 'mrufile', 'changelist', 'quickfix',
\ ]
let g:fuf_maxMenuWidth = 200
let g:fuf_autoPreview = 0
let g:fuf_promptHighlight = 'Question'
let g:fuf_ignoreCase = 1
let g:fuf_timeFormat = '(%Y-%m-%d %H:%M:%S)'
let g:fuf_reuseWindow = 1

let g:fuf_mrufile_maxItem = 220
let g:fuf_mrucmd_maxItem = 100

let g:fuf_keyOpen = 'o'
let g:fuf_keyOpenSplit = 'x'
let g:fuf_keyOpenVsplit = 'v'
let g:fuf_keyOpenTabpage = 't'

" 替换默认的快捷键
let g:fuf_keyPrevMode = '<C-(>'
let g:fuf_keyNextMode = '<C-)>'
let g:fuf_keyPrevPattern = '<C-_>'
let g:fuf_keyNextPattern = '<C-+>'
let g:fuf_keyPreview = '<C-@>'

let g:fuf_mrufile_exclude = '\v\~$|\.(o|so|class|exe|dll|bak|orig|sw[po])$|^(\/\/|\\\\|\/mnt\/)'
let g:fuf_coveragefile_exclude = '\v\~$|\.(o|so|class|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr|gradle|idea|settings)($|[/\\])'
let g:fuf_coveragefile_globPatterns = ['**/.*', '**/*']

let g:fuf_dataDir = expand('$VIM_HOME/.cache/vim-fuf-data')

" let g:priv_fuf_dir_openmode = 'edit'
let g:priv_fuf_dir_openmode = 'NERDTree'
" let g:priv_fuf_current_item = ''
" function! <SID>_CallCoverageFile()
"     exec ':FufCoverageFileChange ' . g:priv_fuf_current_item
" endfunction
" nnoremap <unique> <silent> [search]l  :call <SID>_CallCoverageFile()<CR>
"}}}

nnoremap <unique> <silent> [search]l  :FufCoverageFileChange<CR>
nnoremap <unique> <silent> [search]L  :FufCoverageFileRegister<CR>
nnoremap <unique> <silent> [search]i  :FufBookmarkFile<CR>
nnoremap <unique> <silent> [search]I  :FufBookmarkFileAdd<CR>
nnoremap <unique> <silent> [search]o  :FufBookmarkDir<CR>
nnoremap <unique> <silent> [search]O  :FufBookmarkDirAdd<CR>

" Fix: http://vim.wikia.com/wiki/Script:1984
" For some reason the "BufDelete" autocmd is not working properly under vim 8.0 with FuzzyFinder.vim. A quick fix is to add the following line in .vim/autoload/l9/tempbuffer.vim (line 101):
"
" execute printf('%dbdelete!', s:dataMap[a:bufname].bufNr)
" "TODO: find a better/nicer solution
" execute 'wincmd p'
"
" 1.FuzzyFinder 下载:http://www.vim.org/scripts/script.php?script_id=1984
" 2.vim-l9.vim 下载: http://www.vim.org/scripts/script.php?script_id=3252  "FuzzyFinder依赖该插件
" 3.模式
"     1 |:FufBuffer|       - Buffer mode (|fuf-buffer-mode|)
"     2 |:FufFile|         - File mode (|fuf-file-mode|)
"     3 |:FufCoverageFile| - Coverage-File mode (|fuf-coveragefile-mode|)
"     4 |:FufDir|          - Directory mode (|fuf-dir-mode|)
"     5 |:FufMruFile|      - MRU-File mode (|fuf-mrufile-mode|)
"     6 |:FufMrucmd-mode|)
"     7 |:FufBookmarkFile| - Bookmark-File mode (|fuf-bookmarkfile-mode|)
"     8 |:FufBookmarkDir|  - Bookmark-Dir mode (|fuf-bookmarkdir-mode|)
"     9 |:FufTag|          - Tag mode (|fuf-tag-mode|)
"    10 |:FufBufferTag|    - Buffer-Tag mode (|fuf-buffertag-mode|)
"    11 |:FufTaggedFile|   - Tagged-File mode (|fuf-taggedfile-mode|)
"    12 |:FufJumpList|     - Jump-List mode (|fuf-jumplist-mode|)
"    13 |:FufChangeList|   - Change-List mode (|fuf-changelist-mode|)
"    14 |:FufQuickfix|     - Quickfix mode (|fuf-quickfix-mode|)
"    15 |:FufLine|         - Line mode (|fuf-line-mode|)
"    16 |:FufHelp|         - Help mode (|fuf-help-mode|)
" 4.介绍
"   <c-n> :向下选择匹配      <c-p> :向上选择匹配
"   <c-s> :水平分割选中项    <c-v> :垂直分割选中项    <c-t>:tab打开选中项 <cr> :直接跳到选中项
"   <c-]> :delete select item
"   <c-\><c-\> :fuzzy matching 和 partial matching匹配模式切换 ( 模糊查找 与 部分查找 : 前者输入关键字错误时也可显示, 后者输入的部分关键字一定正确 )
