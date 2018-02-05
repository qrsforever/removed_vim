#!/bin/bash 

DBSHELL=~/.vim/bin/0db.sh
TAG_DIR=`pwd`
SRC_DIR=""

CCGLUE_FLAG=0 $DBSHELL $TAG_DIR $SRC_DIR
