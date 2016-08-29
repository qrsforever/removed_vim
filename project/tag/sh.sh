LOCAL_PATH=`pwd`
OUT_PATH=$tags/xx
SRC_DIRS="xx/xx /xx/xx"

if [[ x"$tags" == x ]] 
then
    echo "You need set "# export tags=xxx/xxx/path
    return 
fi

echo "remove all database files"
find $LOCAL_PATH ! -path "*.sh" -type f | xargs rm -f

echo "Create filenametags database"
source $LOCAL_PATH/filenametags.sh 

if [[ -f $OUT_PATH/filenametags ]]; then
    echo "Create cscope database"
    source $LOCAL_PATH/cs.sh
fi

if [[ -f $OUT_PATH/cscope.files ]]; then
    echo "Create tags database"
    source $LOCAL_PATH/tags.sh
fi
