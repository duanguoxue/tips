#!/bin/bash
#author:dgx
#bash tcp connection

# if already running , exit
PROC_NUM=$(/usr/sbin/lsof $0 | grep -v COMMAND |wc -l)
if [ $PROC_NUM -gt 1 ];then
    echo "already running..."
    exit
fi

exec 3<> /dev/tcp/www.zuoyan.net/80
echo -e "GET / HTTP/1.0\nHOST:www.zuoyan.net\n\n" >&3
#read the Reply
while read -t 1 -n 4096 <&3
do
    echo  $REPLY 
done

# close the file descriptor
exec 3<&-
exec 3>&-

