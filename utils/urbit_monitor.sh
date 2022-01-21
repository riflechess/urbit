#!/bin/bash

dt=$(date '+%Y/%m/%d %H:%M:%S');
echo "$dt - Checking urbit status..."

if  ssh name@10.0.0.0 'bash -s' <<'ENDSSH'
	dt=$(date '+%Y/%m/%d %H:%M:%S');
  	echo "$dt - Server login successful. [OK]"
  	echo "$dt - Checking urbit worker process..."

  	workers=( sitsev ponbes )
  	for i in "${workers[@]}"
	do
		workerCount=$(ps -eaf | grep urbit-worker | grep $i | grep -v grep | wc -l)
	if [[ $workerCount -eq 1 ]]; then
		echo "$dt - $i urbit worker found ($workerCount). [OK]"
	else
		echo "$dt - No $i urbit worker found. [ERROR]"
		curl -X POST https://textbelt.com/text    --data-urlencode phone='5555555555'    --data-urlencode message='Check urbit planet:$i'
 -d key=textbelt
		echo -e "\n"
	fi
	done
ENDSSH
then true
else
  	echo "$dt - Logon failed--check server. [ERROR]"
  	curl -X POST https://textbelt.com/text    --data-urlencode phone='5555555555'    --data-urlencode message='Logon ERROR - Check urbit serv
er' -d key=textbelt
  	echo -e "\n"
fi
