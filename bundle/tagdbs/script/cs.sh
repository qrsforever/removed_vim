CMD_CSCOPE=`which cscope`
CMD_CCGLUE=`which ccglue`

rm -f $OUT_PATH/cscope.files
cut -f2 $OUT_PATH/filenametags > $OUT_PATH/cscope.files

$CMD_CSCOPE -b -c -k -i $OUT_PATH/cscope.files -f $OUT_PATH/cscope.out

echo ":cs kill 0" >> $OUT_PATH/db.vim
echo ":cs kill 1" >> $OUT_PATH/db.vim
echo ":cs kill 2" >> $OUT_PATH/db.vim
echo ":cs reset" >> $OUT_PATH/db.vim
echo ":cs add $OUT_PATH/cscope.out $OUT_PATH" >> $OUT_PATH/db.vim

#Only c , the ccglue work ok.
if [[ x$CMD_CCGLUE == x ]] 
then
    return 
fi

rm -f $OUT_PATH/.c.*
while read line;do
    if [[ "${line##*.}" = "c" ]]; then 
        echo $line >> $OUT_PATH/.c.cscope.files
    fi
done < $OUT_PATH/cscope.files

if [[ -f $OUT_PATH/.c.cscope.files ]]; then
    $CMD_CSCOPE -b -c -i $OUT_PATH/.c.cscope.files -f $OUT_PATH/.c.cscope.out
    $CMD_CCGLUE -S $OUT_PATH/.c.cscope.out -o $OUT_PATH/cctree.out
    echo ":CCTreeLoadXRefDBFromDisk $OUT_PATH/cctree.out" >> $OUT_PATH/db.vim
    rm -f $OUT_PATH/.c.*
fi
