"{{{ Setup

let VCSCommandDisableMappings = 0
let VCSCommandEnableBufferSetup = 0  "slow if set 1
let VCSCommandMapPrefix = ']c'
let VCSCommandMappings = [
    \ ['a', 'VCSAdd'],
    \ ['c', 'VCSCommit'],
    \ ['D', 'VCSDelete'],
    \ ['d', 'VCSDiff'],
    \ ['l', 'VCSLog'],
    \ ['n', 'VCSAnnotate'],
    \ ['q', 'VCSRevert'],
    \ ['r', 'VCSReview'],
    \ ['s', 'VCSStatus'],
    \ ['u', 'VCSUpdate'],
    \ ['v', 'VCSVimDiff'],
\]

augroup VCSCommand
  au User VCSBufferCreated silent! nmap <unique> <buffer> q :bwipeout<cr>
augroup END
"}}}
