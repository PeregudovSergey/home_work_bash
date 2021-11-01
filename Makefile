arch: 
	touch kek 
	touch serv
	touch ratata.cpp
	mkdir empty
	mkdir here_server
	cp server here_server/server
	tar -czvf arch.tar.gz kek serv ratata.cpp empty here_server 
	rm kek 
	rm serv 
	rm ratata.cpp 
	rm -rf empty 
	rm -rf here_server

clear: 
	sudo rm -rf  /home/judge
	sudo userdel judge	
