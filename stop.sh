#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

stop() {

	echo -e "${GREEN}STOP${NC}"
	if [ -f /home/judge/server.pid ]
	then
		echo "[INFO] server.pid exist $(date)" >> /home/judge/server.log
	else 
		echo "[ERROR] server.pid doesn't exist $(date)" >> /home/judge/server.log			
		exit 1
	fi	
	pid=$(head -n 1 /home/judge/server.pid)
	kill $pid
	echo $?
	rm /home/judge/server.pid
}

stop 
