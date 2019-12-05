"{{{ Setup
let g:sync_exe_filenames = '.vim-sync;'
let g:sync_async_upload = 1
let g:sync_async_silent = 1
"}}}

autocmd BufWritePost * :call SyncUploadFile()
" autocmd BufReadPre * :call SyncDownloadFile()

command! MyRsyncUploadFile call g:SyncUploadFile()
" command! MyRsyncDownloadFile call g:SyncDownloadFile()
