#!/bin/bash

APT_FILE=/etc/apt/sources.list

BASH_SCRIPT=${BASH_SOURCE[0]}

if [[ $# != 2 ]]
then
    echo "Usage: ./sed.sh [system type] [provider]"
    echo -e "\t sytem type: ubuntu cn.ubuntu debian ubuntu_aarch64 raspberrypi"
    echo -e "\t   provider: aliyun 163 tsinghua sjtu huawei ustc"
    if [[ $BASH_SCRIPT != $0 ]]
    then
        return
    else
        exit 0
    fi
fi

SYSTEMTY=$1
PROVIDER=$2

if [[ $SYSTEMTY == "ubuntu" ]]
then
    SRC1="http://archive.ubuntu.com"
    SRC2="http://security.ubuntu.com"
elif [[ $SYSTEMTY == "cn.ubuntu" ]]
then
    SRC1="http://cn.archive.ubuntu.com"
    SRC2="http://security.ubuntu.com"
elif [[ $SYSTEMTY == "debian" ]]
then
    SRC1="http://deb.debian.org"
    SRC2="http://security.debian.org"
elif [[ $SYSTEMTY == "ubuntu_aarch64" ]]
then
    SRC1="http://ports.ubuntu.com"
elif [[ $SYSTEMTY == "raspberrypi" ]]
then
    SRC1="http://archive.raspberrypi.org"
    APT_FILE="/etc/apt/sources.list.d/raspi.list"
else
    echo "error system type:[$SYSTEMTY]"
    exit 0
fi

case $PROVIDER in
    163)
        DST="http://mirrors.163.com"
        ;;
    huawei)
        DST="https://mirrors.huaweicloud.com"
        ;;
    tsinghua)
        DST="https://mirrors.tuna.tsinghua.edu.cn"
        ;;
    sjtu)
        DST="https://mirror.sjtu.edu.cn"
        ;;
    ustc)
        if [[ $SYSTEMTY == "raspberrypi" ]]
        then
            DST="http://mirrors.ustc.edu.cn/archive.raspberrypi.org"
        else
            DST="https://mirrors.ustc.edu.cn"
        fi
        ;;
    *)
        DST="http://mirrors.aliyun.com"
        ;;
esac

if [[ $SYSTEMTY == "raspberrypi" ]]
then
    DST="$DST/raspberrypi"
fi

if [[ ! -f ${APT_FILE}.save ]]
then
    sudo cp ${APT_FILE} ${APT_FILE}.save
else
    sudo cp ${APT_FILE}.save ${APT_FILE} 
fi

sudo sed -i "s@${SRC1}@${DST}@g" ${APT_FILE}
if [[ x$SRC2 != x ]]
then
    sudo sed -i "s@${SRC2}@${DST}@g" ${APT_FILE}
fi
