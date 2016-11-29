#!/bin/bash

if [[ $# != 1 ]]
then
    echo "$0 [0/1]"
    exit 
fi

flag=$1

gateway=10.57.176.1
inetarr=(
    10.100.0.0 
    10.110.0.0
    10.140.0.0 
    10.142.0.0 
    10.150.0.0
)

for item in ${inetarr[*]}
do
    if [[ "x$1" == "x1" ]]
    then
        sudo route add -net $item netmask 255.255.0.0 gw $gateway
    else
        sudo route del -net $item netmask 255.255.0.0
    fi
done
