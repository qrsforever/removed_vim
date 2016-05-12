if [[ "$SRC_DIRS" = "" ]]; then
    echo "Please set SRC_DIRS!"
    return ; 
fi

find $SRC_DIRS $SDK_DIRS -regex '.*\.\(c\|cpp\|java\|h\)' ! -path "*svn*" -type f -printf "%f	%p	1\n" | sort -f > $OUT_PATH/filenametags

echo "let g:LookupFile_TagExpr=string('$OUT_PATH/filenametags')"  >> $OUT_PATH/db.vim
