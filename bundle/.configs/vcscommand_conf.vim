"modify vcsccommand.vim line[415] replace line[416] for resovling mapping conflict with c.vim
"415:	"let lhs = VCSCommandGetOption('VCSCommandMapPrefix', '<Leader>c') . a:shortcut
"416:    let lhs = VCSCommandGetOption('VCSCommandMapPrefix', ']c') . a:shortcut
"noremap <Leader>ca    :VCSAdd<CR>
"noremap <Leader>cn    :VCSAnnotate<CR>
"noremap <Leader>cN    :VCSAnnotate!<CR>
"noremap <Leader>cc    :VCSCommit<CR>
"noremap <Leader>cD    :VCSDelete<CR>
"noremap <Leader>cd    :VCSDiff<CR>
"noremap <Leader>cg    :VCSGotoOriginal<CR>
"noremap <Leader>cG    :VCSGotoOriginal!<CR>
"noremap <Leader>ci    :VCSInfo<CR>
"noremap <Leader>cl    :VCSLog<CR>
"noremap <Leader>cL    :VCSLock<CR>
"noremap <Leader>cr    :VCSReview<CR>
"noremap <Leader>cs    :VCSStatus<CR>
"noremap <Leader>cu    :VCSUpdate<CR>
"noremap <Leader>cU    :VCSUnlock<CR>
"noremap <Leader>cv    :VCSVimDiff<CR>        ---------------> Good
noremap ]cr :VCSRevert<CR>
let VCSCommandEnableBufferSetup=0            "slow if set 1
