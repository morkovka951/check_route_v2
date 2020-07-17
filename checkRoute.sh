#! /bin/bash

getNameTun=`ifconfig | grep tun1 | awk {'print $1'} | sed 's/.$//'`
echo $getNameTun
checkTun=`tail -n1 /var/log/openvpn/$getNameTun.log | awk {'print $6'}`
echo $checkTun
getIpServTun=`cat /home/pi/Scripts/Route/tun.txt | grep $getNameTun | awk {'print $2'}`
echo $getIpServTun
getIpCliTun=`cat /home/pi/Scripts/Route/tun.txt | grep $getNameTun | awk {'print $3'}`
getIpRoute=`cat /home/pi/Scripts/Route/tun.txt | grep $getNameTun | awk {'print $4'}`

if [[ $checkTun  == "Initialization" ]];
then
        echo "hello"
        check_route=`route -n | grep $getIpRoute | awk {'print $1'}`
        if [[ $check_route != $getIpRoute ]];
        then
                `route add $getIpRoute gw $getIpServTun dev $getNameTun`
                echo `date` '---> add route'  >> /home/pi/Scripts/Route/route.log
        fi

fi
