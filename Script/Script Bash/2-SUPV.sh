#!/bin/bash
clear
sidebar="------------------------------------------------------------------------------"
echo "Hello Master $USER <3"
echo -e "\n$sidebar"
echo "Il y a actuellement $(netstat -laputen | grep ESTA | wc -l) Connexion établies"
echo -e "\n"
netstat -laputen | grep ESTA | awk -F" " '{print$5"        : "$9}'
echo -e "\n$sidebar"
echo -e "Il y a actuellement $(w -h | wc -l) utilisateurs connectés en SSH"
w -h | awk -F" " '{print$1" : "$3}'
echo -e "$sidebar"
echo -e "Il y a eu $(cat /var/log/auth.log | grep Failed | grep "$(date +%b' '%d)" | wc -l) tentatives de connexionx SSH aujourd'hui"
echo -e "$sidebar"
echo -e "Utilisation des disques : \n$(df -h --output=ipcent,source -t ext4 | grep -v IUse)"