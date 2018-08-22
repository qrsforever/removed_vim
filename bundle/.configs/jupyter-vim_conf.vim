"{{{ Base
let g:jupyter_runflags='-i'
let g:jupyter_auto_connect=0
let g:jupyter_verbose=0
let g:jupyter_mapkeys=1
let g:jupyter_monitor_console=1
let g:jupyter_vsplit=1
"}}}

command Jupyter JupyterConnect

"}}}

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

" 
" https://jupyter-notebook.readthedocs.io/en/stable/config_overview.html

" jupyter 集成 vim
" sudo pip3 install jupyter_contrib_nbextensions
" jupyter nbextensions_configurator enable --user
"
" # You may need the following to create the directoy
" mkdir -p $(jupyter --data-dir)/nbextensions
" # Now clone the repository
" cd $(jupyter --data-dir)/nbextensions
" git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
" chmod -R go-w vim_binding
" jupyter nbextension enable vim_binding/vim_binding
"

" 配置jupyter
" jupyter notebook --generate-config
" jupyter notebook password
