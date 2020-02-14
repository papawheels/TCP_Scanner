#!/bin/bash
# Author: Kaleb Matthews
# Date: 2/12/20
# Version 1.0
# Description: A scanner to scan ports
# Execute: TCP_Scanner.sh 192.168.1.1 443 445
# populate our variables from the arguments
host=$1
startport=$2
stopport=$3

# checks and makes sure you have all parameters
if [ -z "$3" ]; then
echo "please put ending port"
echo "ex: bash TCP_Scanner.sh 192.168.1.1 443 445"
exit 1
fi
# function pingcheck
# ping a device to see if its up
function pingcheck
{
ping=`ping -c 1 $host | grep bytes | wc -l`
if [ "$ping" -gt 1 ];then 
echo "$host target is ready for engagement";
else
echo "$host target is a no-go ";
exit
fi
}
# function portcheck
# test a port to see if its open
function portcheck
{
for ((counter=$startport; counter <= $stopport; counter++))
do 
(echo >/dev/tcp/$host/$counter) > /dev/null 2>&1 && echo "$counter open"
done
}
# run our functions 
pingcheck
portcheck  
