#!/bin/bash

if [ -z $1 ];then
	TRUEMAC="00:0c:29:b5:da:bd"
else
	TRUEMAC=$1
fi

IP_GW=$(ip r | grep default | awk -F " " '{print$3}')
MAC_GW=$(arp -a | grep $IP_GW | awk -F " " '{print$4}')

if [ "$MAC_GW" != "$TRUEMAC" ];then
	echo "Alert Spoofing ARP !" | wall
	echo "Shutdown net adapter .." | wall
	ifdown $(ip r | grep default | ip r | grep default | awk -F " " '{print$6}')
	echo -e "Attaque ARP le $(date +%d/%m/%Y) a $(date +%H:%M:%S) par $MAC_GW"
fi