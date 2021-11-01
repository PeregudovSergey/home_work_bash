class test
{
public:
	test& operator+=(const test& t1)
	{
		///_str + t1; 
	 	
	 	x += t1.x;
	 	test &p = *this; 
	 	return *this;
	} 

private:
	char* _str; 

};

int main()
{
	int l = 3; 
	int *y = &l; 
	int x = *y; 

	test t1;
	t1.x = 25;
	const test t2;
	(t1+=t2) += t2

}