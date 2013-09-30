#!/bin/bash
#author:dgx
#bash tcp connection
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

