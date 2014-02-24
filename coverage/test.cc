#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <algorithm>

using namespace std;
//test atexit 

#define IS_POWER_OF_2(x) (!((x)&((x)-1)))

class ATest{
    public:
        ATest(int iNum):iNum_(iNum){cout << "init :"<<iNum<<endl;}
        ~ATest(){cout << "end:"<<iNum_<<endl;}
    private:
        int iNum_;
};

void helloword(){
    cout<<"hello word!"<<endl;
}
ATest test(0);
int main(){
    printf("\nsizeof (unsigned):%d\n",sizeof(unsigned));
    printf("power of 2:%d\n",IS_POWER_OF_2(3));
    ATest test(1);
    cout<<"i am in main"<<endl;
    atexit(helloword);
    cout<<"i am in main will exit"<<endl;
    string strResult="ABC中古你好，fdsalk，AQDW";
    std::transform(strResult.begin(), strResult.end(), strResult.begin(), ::tolower);
    printf("tolower :%s\n",strResult.c_str());
}

