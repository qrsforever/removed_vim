# Setup fzf
# ---------
if [[ ! "$PATH" == */home/lidong/.vim/bundle/fzf/bin* ]]; then
  export PATH="$PATH:/home/lidong/.vim/bundle/fzf/bin"
fi

export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(gvim {})'"

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/lidong/.vim/bundle/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/lidong/.vim/bundle/fzf/shell/key-bindings.bash"

