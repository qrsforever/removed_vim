#!/bin/bash

COMMAND=$(ps -o comm= $PPID)

# echo "By $TAG_DIR/$COMMAND called"

__usage__()
{
    echo "Usage:"
    echo "   db.sh -s src_dirs [-i ignore_dirs] [-g ccglue enable] [-t tmp tags dir] [-y vim syntastic]"
    exit -1
}

CMD_CSCOPE=`which cscope`
CMD_CTAGS=`which ctags`
CMD_CCGLUE=`which ccglue`
CMD_NTFSND=`which notify-send`

VIM_BIN=`dirname ${BASH_SOURCE[0]}`
VIM_HOME=`dirname $VIM_BIN`

CC_GLUE=0
VIM_SYN=0

while getopts 's:i:t:gy' OPT;
do
    case $OPT in
        s)
            SRC_DIR="$OPTARG"
            ;;
        i)
            IGN_DIR="$OPTARG"
            ;;
        t)
            TAG_DIR="$OPTARG"
            ;;
        g)
            CC_GLUE=1
            ;;
        y)
            VIM_SYN=1
            ;;
        *)
            __usage__
            ;;
    esac
done

shift $(($OPTIND - 1))

SRCS_INCLUDE=''
SRCS_EXCLUDE=''

if [[ x$SRC_DIR == x ]]
then
    SRC_DIR=`cd $TAG_DIR/..; pwd`
fi

if [[ x$COMMAND == x"vim" ]]
then
    SRCS_INCLUDE=$SRC_DIR
    if [[ x$TAG_DIR == x ]]
    then
        TAG_DIR="/tmp/tags/$SRC_DIR/.tags"
    fi
else
    TAG_DIR=`readlink /proc/$PPID/cwd`
    PRO_DIR=`cd $(dirname $TAG_DIR); pwd`
    if [[ x$SRC_DIR == x ]]
    then
        __usage__
        exit -1
    else
        for dir in $SRC_DIR
        do
            SRCS_INCLUDE="$SRCS_INCLUDE $PRO_DIR/${dir}"
        done
    fi

    if [[ x$IGN_DIR != x ]]
    then
        for dir in $IGN_DIR
        do
            SRCS_EXCLUDE="$SRCS_EXCLUDE -path $PRO_DIR/${dir} -prune -o"
        done
    fi
fi

# echo "TAG_DIR = $TAG_DIR"
# echo "SRC_DIR = $SRC_DIR"
# echo "IGN_DIR = $IGN_DIR"
# echo "PRO_DIR = $PRO_DIR"
# echo "SRCS_INCLUDE: $SRCS_INCLUDE"
# echo "SRCS_EXCLUDE: $SRCS_EXCLUDE"

#-----------------------------------------------------------------
# Generate filenametags
#-----------------------------------------------------------------

find $SRCS_INCLUDE $VIM_HOME/tags/test.c $SRCS_EXCLUDE \
    ! -path "*.git*" -a \
    ! -path "*.svn*" -a \
    ! -path "*.tags*" -a \
    ! -path "*out*" -a \
    ! -path "*output*" -a \
    ! -path "*objs*" -a \
    ! -path "*bin*" -a \
    -regex '.*\.\(c\|cpp\|java\|h\|cs\|txt\|aidl\|php\|js\|sh\|conf\|py\)' \
    -type f -printf "%f	%p	1\n" | sort -f > $TAG_DIR/filenametags

cut -f2 $TAG_DIR/filenametags | grep -v aidl > $TAG_DIR/cscope.files
cut -f2 $TAG_DIR/filenametags | grep -E '*.c$|*.cpp$|*.h$|*.java$|*.py$|*.php$' > $TAG_DIR/cscope.tag.files

#-----------------------------------------------------------------
# Generate cscope
#-----------------------------------------------------------------

if [[ x$CC_GLUE == x"1" ]]
then
    KERNEL_FLAG="-k"
fi

$CMD_CSCOPE -bqc $KERNEL_FLAG -i $TAG_DIR/cscope.tag.files -f $TAG_DIR/cscope.out

if [[ x$CC_GLUE == x"1" ]]
then
    if [[ x$CMD_CCGLUE != x ]]
    then
        $CMD_CCGLUE -S $TAG_DIR/cscope.out -o $TAG_DIR/cctree.out
        # line 5,6 is invalid, delete.
        sed -i '5,6d' $TAG_DIR/cctree.out
    fi
fi

#-----------------------------------------------------------------
# Generate ctag
#-----------------------------------------------------------------

result=`ctags --version | grep Universal`
if [[ x$result != x ]]
then
    t="s"
else
    t=""
fi
$CMD_CTAGS -I __THROW --c++-kinds=+p --fields=+ialS --extra$t=+q -L $TAG_DIR/cscope.tag.files -o $TAG_DIR/tags

#-----------------------------------------------------------------
# Generate c/c++ header dirs
#-----------------------------------------------------------------

if [[ x$VIM_SYN == x"1" ]]
then
    dirname `find $SRCS_INCLUDE -name "*.h" -or -name "*.H" ` 2>/dev/null | sort -u > $TAG_DIR/header_dirs.txt
fi

#-----------------------------------------------------------------
# Notify infomation
#-----------------------------------------------------------------

if [[ x$CMD_NTFSND != x ]]
then
    $CMD_NTFSND "Generate $(dirname $TAG_DIR) ok!"
fi
