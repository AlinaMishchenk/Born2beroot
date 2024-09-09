#!/bin/bash

#The architecture of your operating system and its kernel version

uname -ov | awk  {'print "#Architecture: \t" $0'}

#The number of physical processors

lscpu | grep '^CPU(s):' | awk '{print "#CPU physical: \t" $2 }'

#The number of virtual processors/logical CPU

lscpu | grep 'Thread(s) per core:' | awk '{ print "#vCPU: \t" $4 }'

#The current avail. RAM and its utilization rate as a \percentage

 free -m | awk 'NR==2{printf "Available RAM: %sMB | Utilization: %.2f%%\n", $7, $3*(100/$2) }'

#The current available storage on your server and its utilization rate as %

df -h / | awk 'NR==2 {printf "Available Storage: %s | Utilization: %s\n", $4, $5}' 

#The current utilization rate of your processors as a percentage

top -bn1 | grep "Cpu(s)" | awk -F" " '{printf "#CPU load: \t"$2 }'


#The date and time of the last reboot

who -b | awk '{print "System boot:", $3, $4}'

#Whether LVM is active or not.

if pvs &> /dev/null; then
printf "LVM use: yes\n"
else
printf "LVM use: no\n"
fi


#The number of active connections

printf "Connections TCP: %d ESTABLISHED\n" $(ss -tna | grep ESTAB | wc -l)


#The number of users using the server.

printf "User log: %d\n" $(users | wc -w)

#The IPv4 address of your server and its MAC (Media Access Control) address
echo "IPv4 Address: $(hostname -I | awk '{print $1}') | MAC Address: $(ip link | grep 'link/ether' | awk '{print $2}' | head -n 1)"



#The number of commands executed with the sudo program

sudo journalctl _COMM=sudo | wc -l | awk '{print "sudo:", $1}'


another

#!/bin/bash

#The architecture of your operating system and its kernel version

uname -ov | awk  {'print "#Architecture: \t" $0'}

#The number of physical processors

lscpu | grep '^CPU(s):' | awk '{ print "#CPU physical: \t" $2 }'

#The number of virtual processors/logical CPU

lscpu | grep 'Thread(s) per core:' | awk '{ print "#vCPU: \t" $4 }'

#The current avail. RAM and its utilization rate as a percentage

free -m | awk 'NR==2{printf "Available RAM: %sMB\nUtilization: %.2f%\n", $7, $3*100/$2 }'

#The current available storage on your server and its utilization rate as %

df -h / | awk 'NR==2 {printf "Available Storage: %s\nUtilization: %s\n", $4, $5}'

#The current utilization rate of your processors as a percentage?

top -bn1 | grep "Cpu(s)" | awk -F" " '{printf "#CPU load: \t"$2 }'


#The date and time of the last reboot

who -b

#Whether LVM is active or not

if pvs &> /dev/null; then
printf "LVM use: yes\n"
else
printf "LVM use: no\n"
fi


#The number of active connections

printf "Connections TCP: %d ESTABLISHED\n" $(ss -tna | grep ESTAB | wc -l)


#The number of users using the server.

printf "User log: %d\n" $(users | wc -w)

#The IPv4 address of your server and its MAC (Media Access Control) address
echo "IPv4 Address: $(ifconfig | grep 'inet ' | awk '{print $2}' | head -n 1)"
echo "MAC Address: $(ifconfig | grep 'ether ' | awk '{print $2}' | head -n 1)"


#The number of commands executed with the sudo program
grep 'sudo:' /var/log/auth.log | wc -l
