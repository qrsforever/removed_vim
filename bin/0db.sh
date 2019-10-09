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
VIM_HOME=`cd $VIM_BIN/..; pwd`

CC_GLUE=0
VIM_SYN=0

TAG_DIR=`readlink /proc/$PPID/cwd`
PRO_DIR=`cd $(dirname $TAG_DIR); pwd`

SRCS_INCLUDE=
SRCS_EXCLUDE=

while getopts 's:i:t:gy' OPT;
do
    case $OPT in
        s)
            SRC_DIR="$OPTARG"
            path=$PRO_DIR/${SRC_DIR}
            if [[ ! -d $path ]]
            then
                path=$SRC_DIR
            fi
            SRCS_INCLUDE="$SRCS_INCLUDE $path"
            ;;
        i)
            IGN_DIR="$OPTARG"
            path=$PRO_DIR/${IGN_DIR}
            if [[ ! -d $path ]]
            then
                path=$SRC_DIR
            fi
            SRCS_EXCLUDE="$SRCS_EXCLUDE -path ${path} -prune -o"
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

if [[ x$COMMAND == x"vim" ]]
then
    SRCS_INCLUDE=$SRC_DIR
    if [[ x$TAG_DIR == x ]]
    then
        TAG_DIR="/tmp/tags/$SRC_DIR/.tags"
    fi
else
    if [[ x$SRCS_INCLUDE == x ]]
    then
        SRCS_INCLUDE=$PRO_DIR
    fi
    echo "TAG_DIR = $TAG_DIR"
    echo "PRO_DIR = $PRO_DIR"
    echo "SRCS_INCLUDE: $SRCS_INCLUDE"
    echo "SRCS_EXCLUDE: $SRCS_EXCLUDE"
fi

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
    $CMD_NTFSND -i $VIM_HOME/res/icons/dialog-information.png hexo "TagDB Generate $(dirname $TAG_DIR) ok!"
fi
