"{{{ Base
let g:jupyter_runflags='-i'
let g:jupyter_auto_connect=0
let g:jupyter_verbose=0
let g:jupyter_mapkeys=1
let g:jupyter_monitor_console=0
"}}}

command Jupyter JupyterRunFile
"
" --------------------------------------------------------------------------------
" MAPPINGS					*jupyter-vim-mappings*
" 
" <LocalLeader>R 		Run the current file (see |:JupyterRunFile|).
" <LocalLeader>I 		Import the current file (see |:JupyterImportThisFile|).
" <localleader>d 		Change to the directory of the current file (see |:JupyterCd|).
" <localleader>X 		Execute the current cell (see |:JupyterSendCell|).
" <localleader>E 		Execute the current line (see |:JupyterSendRange|).
" 
" <localleader>e 		Execute vim text |objects|
" {Visual}<localleader>e  Execute the |visual| selection
" 
" <localleader>U          Update the kernel I/O messages in the pseudo console.
" 			Open up a split for display if it is not already open 
" 			(see |:JupyterUpdateShell|).
" 
" <localleader>b 		Insert a breakpoint at the current line.
" 
" --------------------------------------------------------------------------------
