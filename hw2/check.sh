#!/bin/bash

name=$1
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


run-sanitize() {

	touch sanitize
	make --silent name?=${name} -f Makefile debug 2> sanitize
	if [ -s sanitize ]
	then
		echo -e "${RED}Fail on sanitize${NC}"
		cat sanitize
		exit 1
	else
		echo -e "${GREEN}Sanitize check OK${NC}"
	fi	

}

check-format() {

	touch format
	#clang-format -i --style=Google ${name}.cpp 2> format 
	clang-format -dry-run --style=Google ${name}.cpp 2> format 
	if [ -s format ] 
	then
		echo -e "${RED}Fail on code-style check${NC}"
		cat format
		exit 1
	else
		echo -e "${GREEN}Code-style check OK${NC}"
	fi

}


fast_run() {

	start_time=$(date +%s%N)
	make --silent name?=${name} -f Makefile release
	end_time=$(date +%s%N)
	let dif=($end_time - $start_time)
	pt_sec=1000000000
	pt_ms=1000000
	let sec=($dif / $pt_sec)
	let ms=($dif / $pt_ms)
	echo -e "${GREEN}Benchmark time $sec.${ms}s${NC}"

}


echo -e "${GREEN}Check ${name}.cpp...${NC}"

run-sanitize

check-format

fast_run 
