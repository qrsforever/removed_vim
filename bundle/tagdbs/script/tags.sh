CMD_CTAGS=`which ctags`

$CMD_CTAGS -I __THROW --c++-kinds=+p --fields=+ialS --extra=+q -L $OUT_PATH/cscope.files -o $OUT_PATH/tags

echo "set tags+=$OUT_PATH/tags" >> $OUT_PATH/db.vim
