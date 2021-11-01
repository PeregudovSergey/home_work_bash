name=main
debug: 
	g++ -g ${name}.cpp -D DEBUG -std=c++17 -Wall -Wextra -Wshadow -Wfloat-equal -Wduplicated-cond -fsanitize=address -fsanitize=undefined
	
release: 
	g++ -g ${name}.cpp -std=c++17 -Wall -Wextra -Wshadow -Wfloat-equal -Wduplicated-cond -O3

clear: 
	rm -rf *.o *.out
