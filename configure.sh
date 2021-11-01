#!/bin/bash

#sudo userdel judge


RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
path_to_server=empty


create_judge() {	

	echo -e "${GREEN}[OK] create_judge${NC}"

	RESULT=$(sed 's/:.*//' /etc/passwd | grep judge)

	if [ "$RESULT" == judge ]
	then 
		echo -e "${RED}[ERROR] judge already exist${NC}"		
		exit 1
	else
		sudo useradd -m judge
		sudo chmod -R u=rwx,g=rwx,o=rwx /home/judge	
	fi 

}


download_archive() {

	echo -e "${GREEN}[OK] download_archive${NC}"
	#download arch named arch///wget
	tar -xf arch.tar.gz -C /home/judge/

}

owner() {

	echo -e "${GREEN}[OK] owner${NC}"
	sudo chown -R judge /home/judge

}



find_server() {

	echo -e "${GREEN}[OK] find_server${NC}"
	path_to_server=$(find /home/judge -name "server")
	#echo $judge_path
	echo export PATH=\$PATH:$path_to_server >> /home/judge/.bashrc

}

setting_mods() {

	echo -e "${GREEN}[OK] setting_mods${NC}"
	sudo chgrp -R $(whoami) /home/judge
	sudo chmod -R u=r,g=rwx,o-r-w-x /home/judge
	find /home/judge -type d -exec sudo chmod +x {} +
	sudo chmod u+x $path_to_server

}

create_judge

download_archive

owner 

find_server

setting_mods
