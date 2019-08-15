#!/bin/bash 

#===============TagDir=====================
#!/bin/bash 
# SCRIPT_DB=~/.vim/bin/0db.sh
# TAG_DIR=`pwd`
# SRC_DIR="\
#   dir1 \
#   dir2 \
#   dir3"
# 
# $SCRIPT_DB $TAG_DIR $SRC_DIR
#===============TagDir=====================

if (( $# < 2 ))
then
    echo "use: 0db.sh tag_dir src_dir"
    exit
fi

((DIR_NUM = $# - 1))

DIRS=($@)
TAG_DIR=$1
SRC_DIR=${DIRS[@]: 1:$DIR_NUM}

echo "DirNum = $DIR_NUM"
echo "TagDir = $TAG_DIR"
echo "SrcDir = $SRC_DIR"

CMD_CSCOPE=`which cscope`
CMD_CTAGS=`which ctags`
CMD_CCGLUE=`which ccglue`

find $SRC_DIR -regex '.*\.\(c\|cpp\|java\|h\|cs\|txt\|aidl\|php\|js\|sh\|conf\|py\)' \
    ! -path "*git*" -and \
    ! -path "*svn*" -and \
    ! -path ".tags*" -and \
    ! -path "out*" -and \
    ! -path "output*" -and \
    ! -path "*bin*" -and \
    -type f -printf "%f	%p	1\n" | sort -f > $TAG_DIR/filenametags
 
cut -f2 $TAG_DIR/filenametags | grep -v aidl > $TAG_DIR/cscope.files
cut -f2 $TAG_DIR/filenametags | grep -E '*.c$|*.cpp$|*.h$|*.java$' > $TAG_DIR/cscope.tag.files
if [[ x$CCGLUE_FLAG != x"1" ]]
then
    KERNEL_FLAG="-k"
fi

$CMD_CSCOPE -bqc $KERNEL_FLAG -i $TAG_DIR/cscope.tag.files -f $TAG_DIR/cscope.out
if [[ x$CCGLUE_FLAG == x"1" ]]
then
    if [[ x$CMD_CCGLUE != x ]]
    then
        $CMD_CCGLUE -S $TAG_DIR/cscope.out -o $TAG_DIR/cctree.out
        # line 5,6 is invalid, delete.
        sed -i '5,6d' $TAG_DIR/cctree.out
    fi
fi
result=`ctags --version | grep Universal`
if [[ x$result != x ]]
then
    t="s"
else
    t=""
fi
$CMD_CTAGS -I __THROW --c++-kinds=+p --fields=+ialS --extra$t=+q -L $TAG_DIR/cscope.tag.files -o $TAG_DIR/tags
dirname `find $SRC_DIR -name "*.h" -or -name "*.H" ` 2>/dev/null | sort -u > $TAG_DIR/include_dirs.txt
