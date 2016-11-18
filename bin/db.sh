#!/bin/bash 

if [[ $# != 2 ]]
then
    echo "use: db.sh tag_dir src_dir"
fi

TAG_DIR=$1
SRC_DIR=$2

CMD_CSCOPE=`which cscope`
CMD_CTAGS=`which ctags`

find $SRC_DIR -regex '.*\.\(c\|cpp\|java\|h\|cs\)' ! -path "*git*" -and ! -path "*svn*" -and ! -path "*tags*" -type f -printf "%f	%p	1\n" | sort -f > $TAG_DIR/filenametags
echo "let g:LookupFile_TagExpr=string('$TAG_DIR/filenametags')"  > $TAG_DIR/db.vim
 
cut -f2 $TAG_DIR/filenametags > $TAG_DIR/cscope.files
$CMD_CSCOPE -b -c -k -i $TAG_DIR/cscope.files -f $TAG_DIR/cscope.out
echo ":cs kill 0" >> $TAG_DIR/db.vim
echo ":cs kill 1" >> $TAG_DIR/db.vim
echo ":cs kill 2" >> $TAG_DIR/db.vim
echo ":cs reset" >> $TAG_DIR/db.vim
echo ":cs add $TAG_DIR/cscope.out $TAG_DIR" >> $TAG_DIR/db.vim
 
$CMD_CTAGS -I __THROW --c++-kinds=+p --fields=+ialS --extra=+q -L $TAG_DIR/cscope.files -o $TAG_DIR/tags
echo "set tags+=$TAG_DIR/tags" >> $TAG_DIR/db.vim
