#!/bin/bash

#The architecture of your operating system and its kernel version

echo 
uname -o -v
echo

#The number of physical processors

grep "physical id" /proc/cpuinfo | sort -u | wc -l

#The number of virtual processors/logical CPU

grep '^processor' /proc/cpuinfo | wc -l

#The current avail. RAM and its utilization rate as a percentage
 
free | awk '/Mem:/ {printf("RAM Utilization: %.2f%%\n", 100 * ($3 / $2))}'

#The current available storage on your server and its utilization rate as %

df -h | awk '$NF=="/"{printf("Disk Utilization: %.2f%%\n", 100 * ($3 / $2))}'

#The current utilization rate of your processors as a percentage?

grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}' 

#The date and time of the last reboot

who -b

#Whether LVM is active or not ? 

if vgs --noheadings | grep -q .; then
    echo "yes"
else
    echo "no"
fi

#The number of active connections

ss -tna | grep ESTAB | wc -l

#The number of users using the server.

users | wc -w

#The IPv4 address of your server and its MAC (Media Access Control) address
echo "IPv4 Address: $(ip -4 addr show | grep inet | awk '{print $2}' | cut -d/ -f1)"
echo "MAC Address: $(ip link show | grep ether | awk '{print $2}')"

#The number of commands executed with the sudo program
grep 'sudo:' /var/log/auth.log | wc -l
