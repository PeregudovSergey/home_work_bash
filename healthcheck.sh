#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
path_to_server=$(find /home/judge -name "server")

sudo touch /home/judge/server.log
sudo chmod 777 /home/judge/server.log

run_healthcheck() {
	while [ "1" == "1" ] 
	do
		sleep 5 
		if [ -f /home/judge/server.pid ]
		then
			echo "[INFO] server.pid exist $(date)" >> /home/judge/server.log
		else 
			echo "[ERROR] server.pid doesn't exist $(date)" >> /home/judge/server.log			
			exit 1
		fi

		pid=$(head -n 1 /home/judge/server.pid)
		kill -0 $pid 2> /dev/null
		code=$?
		if [ "$code" == "0" ]
		then
			name_command=$(ps -fp $pid -o command=)
			if [ "$name_command" == "$path_to_server" ]
			then
				sudo echo "[server OK]$(date)" >> /home/judge/server.log
			else
				sudo echo "[DEAD] delete server.pid" >> /home/judge/server.log
				rm /home/judge/server.pid
				sudo echo "status $?" >> /home/judge/server.log
				exit 1
			fi
		else
			sudo echo "[DEAD] delete server.pid" >> /home/judge/server.log
			sudo rm /home/judge/server.pid
			sudo echo "status $?" >> /home/judge/server.log
			exit 1
		fi	
	done
}

run_healthcheck	
