#!/bin/bash

PASSFILE="/tmp/passfound.txt"

find $1 -type f \( -name "*pass*" -o -name "*pwd*" -o -name "*pass*" -o -name "*passwd*" \) >>$PASSFILE  2>>/dev/null
egrep -r '(password | passwd | pwd)' $1 | awk -F":" '{print$1}' >>$PASSFILE 2>/dev/null

echo "$(cat /tmp/passfound.txt | sort| uniq | wc -l) mots de passe trouvés"