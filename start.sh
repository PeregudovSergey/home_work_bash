#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

#48405

path_to_server=empty
path_to_server=$(find /home/judge -name "server")

run_server() {

	$path_to_server &
	code=$?
	pid=$!
	#kill $pid
	echo $pid > /home/judge/server.pid

	if [ "$code" == "0" ] 
	then 
		echo -e "${GREEN}[OK] run server${NC}"
		echo -e "${GREEN}[LOG] status = $code${NC}"		
		
		echo -e "${GREEN}RUN HEALTHCHECK${NC}"		
		sudo nohup bash healthcheck.sh 2> /dev/null &		
	else 
		echo -e "${RED}[ERROR] run server${NC}"
		echo -e "${RED}[LOG] status=$code${NC}"				
		exit 1
	fi

}

run_server