"{{{ Setup

let VCSCommandDisableMappings = 0
let VCSCommandEnableBufferSetup = 0  "slow if set 1
" bzr revert 会生成类似xxx.~1~备份文件
let VCSCommandVCSTypePreference = ['git', 'bzr', 'svn', 'hg']
let VCSCommandMapPrefix = ']c'
" see vim-gitgutter key map
let VCSCommandMappings = [
    \ ['a', 'VCSAdd'],
    \ ['c', 'VCSCommit'],
    \ ['d', 'VCSDiff'],
    \ ['l', 'VCSLog'],
    \ ['q', 'VCSRevert'],
    \ ['r', 'VCSReview'],
    \ ['s', 'VCSStatus'],
    \ ['v', 'VCSVimDiff'],
\]

"   \ ['n', 'VCSAnnotate'],
"   \ ['D', 'VCSDelete'],
"   \ ['u', 'VCSUpdate'],

augroup VCSCommand
  au User VCSBufferCreated silent! nmap <unique> <buffer> q :bwipeout<cr>
augroup END
"}}}
