#!/bin/bash

# Setup fzf
# ---------------

current_file=${BASH_SOURCE[0]}
if [[ -L $current_file ]]
then
    tmp_fil=`readlink $current_file`
    tmp_dir=`dirname $tmp_fil`
    vim_dir=`dirname $tmp_dir`
else
    tmp_dir=`dirname $current_file`
    vim_dir=`dirname $tmp_dir`
fi

if [[ ! "$PATH" == *$vim_dir/extern/fzf/bin* ]]; then
      export PATH="$PATH:$vim_dir/extern/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$vim_dir/extern/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$vim_dir/extern/fzf/shell/key-bindings.bash"

alias dfzf='cd $(find * -type d | fzf)'
alias vfzf='vim $(fzf)'
